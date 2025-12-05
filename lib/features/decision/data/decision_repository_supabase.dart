import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthUser;

import '../../auth/domain/auth_repository.dart';
import '../../auth/domain/auth_user.dart';
import '../domain/decision_repository.dart';
import '../domain/entities/decision.dart';

@LazySingleton(as: DecisionRepository)
class SupabaseDecisionRepository implements DecisionRepository {
  final SupabaseClient _client;
  final AuthRepository _authRepository;

  SupabaseDecisionRepository(this._client, this._authRepository);

  Future<AuthUser> _requireUser() async {
    final user = await _authRepository.currentUser;
    if (user == null) {
      throw StateError('User must be logged in to access decisions.');
    }
    return user;
  }

  @override
  Future<Decision> saveDecision(Decision decision) async {
    final authUser = await _requireUser();
    final now = DateTime.now().toUtc();

    final row = _toRow(decision, authUser.id, now);

    // INSERT new decision
    if (decision.id == null) {
      final inserted = await _client
          .from('decisions')
          .insert(row)
          .select()
          .single();

      return _fromRow(inserted);
    }

    // UPDATE existing decision
    final id = decision.id;
    if (id == null) {
      throw StateError('Cannot update decision without id.');
    }

    final updated = await _client
        .from('decisions')
        .update(row)
        .eq('id', id)
        .eq('user_id', authUser.id)
        .isFilter('deleted_at', null)
        .select()
        .maybeSingle();

    if (updated == null) {
      throw StateError('Decision not found or not owned by current user.');
    }

    return _fromRow(updated);
  }

  @override
  Future<List<Decision>> getHistory() async {
    final authUser = await _requireUser();

    final rows = await _client
        .from('decisions')
        .select()
        .eq('user_id', authUser.id)
        .isFilter('deleted_at', null)
        .order('created_at', ascending: false);

    return rows.map<Decision>((row) => _fromRow(row)).toList();
  }

  @override
  Future<Decision?> getDecision(DecisionId id) async {
    final authUser = await _requireUser();

    final row = await _client
        .from('decisions')
        .select()
        .eq('id', id)
        .eq('user_id', authUser.id)
        .maybeSingle();

    if (row == null) return null;

    final decision = _fromRow(row);

    // If soft deleted, treat as not found for normal use
    if (decision.deletedAt != null) return null;

    return decision;
  }

  @override
  Future<void> softDeleteDecision(DecisionId id) async {
    final authUser = await _requireUser();
    final now = DateTime.now().toUtc();

    final updated = await _client
        .from('decisions')
        .update({
          'deleted_at': now.toIso8601String(),
          'updated_at': now.toIso8601String(),
        })
        .eq('id', id)
        .eq('user_id', authUser.id)
        .isFilter('deleted_at', null) // only delete active ones
        .select()
        .maybeSingle();

    if (updated == null) {
      throw StateError('Decision not found or already deleted.');
    }
  }

  // ---------- Helpers for mapping ----------

  Map<String, dynamic> _toRow(Decision decision, String userId, DateTime now) {
    return <String, dynamic>{
      if (decision.id != null) 'id': decision.id,
      'user_id': userId,
      'title': decision.title,
      'description': decision.description,
      'options': decision.options
          .map(
            (o) => {'id': o.id, 'label': o.label, 'description': o.description},
          )
          .toList(),
      'criteria': decision.criteria
          .map((c) => {'id': c.id, 'label': c.label, 'weight': c.weight})
          .toList(),
      'scores': decision.scores,
      'result': decision.result == null
          ? null
          : {
              'best_option_id': decision.result!.bestOptionId,
              'scores': decision.result!.scores,
              'ranking': decision.result!.ranking,
            },
      if (decision.createdAt != null)
        'created_at': decision.createdAt!.toIso8601String(),
      'updated_at': now.toIso8601String(),
      if (decision.deletedAt != null)
        'deleted_at': decision.deletedAt!.toIso8601String(),
    };
  }

  Decision _fromRow(Map<String, dynamic> row) {
    final optionsRaw = row['options'] as List<dynamic>? ?? const [];
    final options = optionsRaw
        .map<DecisionOption>(
          (o) => DecisionOption(
            id: o['id'] as String,
            label: o['label'] as String,
            description: o['description'] as String?,
          ),
        )
        .toList();

    final criteriaRaw = row['criteria'] as List<dynamic>? ?? const [];
    final criteria = criteriaRaw
        .map<DecisionCriterion>(
          (c) => DecisionCriterion(
            id: c['id'] as String,
            label: c['label'] as String,
            weight: (c['weight'] as num?)?.toDouble() ?? 1.0,
          ),
        )
        .toList();

    final scoresRaw =
        (row['scores'] as Map<String, dynamic>?) ?? <String, dynamic>{};
    final scores = scoresRaw.map<ScoreKey, double>(
      (key, value) => MapEntry(key, (value as num).toDouble()),
    );

    final resultRaw = row['result'] as Map<String, dynamic>?;
    DecisionResult? result;
    if (resultRaw != null) {
      final resultScoresRaw =
          (resultRaw['scores'] as Map<String, dynamic>? ?? {});
      final resultScores = resultScoresRaw.map<OptionId, double>(
        (key, value) => MapEntry(key, (value as num).toDouble()),
      );
      final rankingRaw = resultRaw['ranking'] as List<dynamic>? ?? const [];

      result = DecisionResult(
        bestOptionId: resultRaw['best_option_id'] as String,
        scores: resultScores,
        ranking: rankingRaw.cast<String>().toList(),
      );
    }

    return Decision(
      id: row['id'] as String?,
      title: row['title'] as String,
      description: row['description'] as String?,
      options: options,
      criteria: criteria,
      scores: scores,
      result: result,
      createdAt: row['created_at'] != null
          ? DateTime.tryParse(row['created_at'] as String)
          : null,
      updatedAt: row['updated_at'] != null
          ? DateTime.tryParse(row['updated_at'] as String)
          : null,
      deletedAt: row['deleted_at'] != null
          ? DateTime.tryParse(row['deleted_at'] as String)
          : null,
    );
  }
}
