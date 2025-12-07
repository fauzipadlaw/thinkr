import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:thinkr/core/extensions/context_extension.dart';
import 'package:thinkr/core/routes/app_routes.dart';
import 'package:thinkr/features/decision/domain/entities/decision.dart';
import 'package:thinkr/core/theme/app_colors.dart';
import 'package:thinkr/l10n/app_localizations.dart';
import 'decision_result_cubit.dart';
import 'decision_result_state.dart';

class DecisionResultArgs {
  final Decision decision;
  final bool fromEditor;

  const DecisionResultArgs({
    required this.decision,
    this.fromEditor = false,
  });
}

class DecisionResultPage extends StatelessWidget {
  final Decision decision;
  final bool fromEditor;

  const DecisionResultPage({
    super.key,
    required this.decision,
    this.fromEditor = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DecisionResultCubit(decision),
      child: _DecisionResultView(fromEditor: fromEditor),
    );
  }
}

class _DecisionResultView extends StatelessWidget {
  final bool fromEditor;

  const _DecisionResultView({required this.fromEditor});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DecisionResultCubit, DecisionResultState>(
      builder: (context, state) {
        final result = state.decision.result;
        final loc = context.loc;
        final theme = Theme.of(context);

        if (result == null) {
          return PopScope(
            canPop: !fromEditor,
            onPopInvoked: (didPop) {
              if (didPop) return;
              if (fromEditor) GoRouter.of(context).go(AppRoutes.home);
            },
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    if (fromEditor) {
                      GoRouter.of(context).go(AppRoutes.home);
                    } else {
                      Navigator.of(context).maybePop();
                    }
                  },
                ),
                title: Text(loc.decision_editor_title),
              ),
              body: Center(
                child: Text(
                  loc.decision_editor_subtitle,
                  style: theme.textTheme.titleMedium,
                ),
              ),
            ),
          );
        }

        return PopScope(
          canPop: !fromEditor,
          onPopInvoked: (didPop) {
            if (didPop) return;
            if (fromEditor) GoRouter.of(context).go(AppRoutes.home);
          },
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  if (fromEditor) {
                    GoRouter.of(context).go(AppRoutes.home);
                  } else {
                    Navigator.of(context).maybePop();
                  }
                },
              ),
              title: Text(loc.decision_editor_evaluatedChip),
            ),
            body: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.bgDeep, AppColors.bgResult],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 900),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _BestOptionCard(
                            title: state.decision.title,
                            description: state.decision.description,
                            best: state.best,
                            method: state.decision.method,
                            errorRate: state.errorRate,
                            ahpConsistency: state.ahpConsistency,
                            stability: state.stability,
                            overlapReliability: state.fuzzyOverlapReliability,
                            marginReliability: state.marginReliability,
                            combinedReliability: state.combinedReliability,
                          ),
                          const SizedBox(height: 16),
                          _MetaChips(decision: state.decision),
                          const SizedBox(height: 16),
                        _RankingList(ranking: state.ranking),
                        const SizedBox(height: 16),
                        _ResultNotes(),
                        const SizedBox(height: 16),
                        if (result.debug != null && result.debug!.isNotEmpty)
                          _DebugCard(debug: result.debug!),
                      ],
                    ),
                  ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BestOptionCard extends StatelessWidget {
  final String title;
  final String? description;
  final RankingEntry? best;
  final DecisionMethod method;
  final double errorRate;
  final double? ahpConsistency;
  final double? stability;
  final double? overlapReliability;
  final double? marginReliability;
  final double? combinedReliability;

  const _BestOptionCard({
    required this.title,
    required this.description,
    required this.best,
    required this.method,
    required this.errorRate,
    this.ahpConsistency,
    this.stability,
    this.overlapReliability,
    this.marginReliability,
    this.combinedReliability,
  });

  String _methodLabel(DecisionMethod method, AppLocalizations loc) {
    switch (method) {
      case DecisionMethod.weightedSum:
        return loc.decision_editor_methodWeighted;
      case DecisionMethod.ahp:
        return loc.decision_editor_methodAhp;
      case DecisionMethod.fuzzyWeightedSum:
        return loc.decision_editor_methodFuzzy;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = context.loc;
    final reliability =
        (combinedReliability ?? (1 - errorRate)).clamp(0, 1);
    String reliabilityLabel = loc.result_reliabilityNA;
    Color reliabilityColor = theme.colorScheme.onSurfaceVariant;

    if (combinedReliability == null && errorRate == 0) {
      reliabilityLabel = loc.result_reliabilityNA;
      reliabilityColor = theme.colorScheme.onSurfaceVariant;
    } else if (reliability < 0.05) {
      reliabilityLabel = loc.result_reliabilityVeryLow;
      reliabilityColor = Colors.red;
    } else if (reliability < 0.15) {
      reliabilityLabel = loc.result_reliabilityLow;
      reliabilityColor = Colors.deepOrange;
    } else if (reliability < 0.30) {
      reliabilityLabel = loc.result_reliabilityMedium;
      reliabilityColor = Colors.amber;
    } else {
      reliabilityLabel = loc.result_reliabilityHigh;
      reliabilityColor = Colors.green;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withValues(alpha: 0.14),
            theme.colorScheme.secondary.withValues(alpha: 0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: theme.colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.isEmpty ? loc.decision_editor_titleHint : title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onPrimary,
            ),
          ),
          if (description?.isNotEmpty ?? false) ...[
            const SizedBox(height: 8),
            Text(
              description!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onPrimary.withValues(alpha: 0.72),
              ),
            ),
          ],
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Chip(
                avatar: const Icon(Icons.auto_graph, size: 18),
                label: Text(_methodLabel(method, loc)),
              ),
              Chip(
                backgroundColor: reliabilityColor.withValues(alpha: 0.16),
                avatar: Icon(Icons.shield, size: 18, color: reliabilityColor),
                label: Text(
                  '${loc.result_reliabilityLabel} $reliabilityLabel (${(reliability * 100).toStringAsFixed(0)}%)',
                  style: TextStyle(color: reliabilityColor),
                ),
              ),
              if (stability != null)
                Chip(
                  avatar: const Icon(Icons.sync, size: 18),
                  label: Text(
                    '${loc.result_stabilityLabel} ${(stability! * 100).toStringAsFixed(0)}%',
                  ),
                ),
              if (overlapReliability != null)
                Chip(
                  avatar: const Icon(Icons.blur_on, size: 18),
                  label: Text(
                    '${loc.result_overlapLabel} ${(overlapReliability! * 100).toStringAsFixed(0)}%',
                  ),
                ),
              if (method == DecisionMethod.ahp && ahpConsistency != null)
                Chip(
                  backgroundColor:
                      (ahpConsistency! < 0.1
                              ? Colors.green
                              : ahpConsistency! < 0.2
                              ? Colors.orange
                              : Colors.red)
                          .withValues(alpha: 0.14),
                  avatar: Icon(
                    Icons.scale,
                    size: 18,
                    color: ahpConsistency! < 0.1
                        ? Colors.green
                        : ahpConsistency! < 0.2
                        ? Colors.orange
                        : Colors.red,
                  ),
                  label: Text(
                    '${loc.result_ahpConsistencyLabel} ${ahpConsistency!.toStringAsFixed(3)}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: ahpConsistency! < 0.1
                          ? Colors.green
                          : ahpConsistency! < 0.2
                          ? Colors.orange
                          : Colors.red,
                    ),
                  ),
                ),
              if (best != null)
                Chip(
                  backgroundColor: Colors.green.withValues(alpha: 0.12),
                  avatar: const Icon(Icons.emoji_events, color: Colors.green),
                  label: Text(
                    '${loc.decision_editor_scoreOptionHeader}: ${best!.label}',
                  ),
                ),
            ],
          ),
          if (best != null) ...[
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: theme.colorScheme.outlineVariant),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.star_rounded,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loc.decision_editor_evaluatedChip,
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        Text(
                          best!.label,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    best!.score.toStringAsFixed(3),
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ResultNotes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final theme = Theme.of(context);

    final items = [
      loc.result_notesReliability,
      loc.result_notesStability,
      loc.result_notesOverlap,
      loc.result_notesAhpCr,
    ];

    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.result_notesTitle,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ...items.map(
              (text) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• '),
                    Expanded(
                      child: Text(
                        text,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RankingList extends StatelessWidget {
  final List<RankingEntry> ranking;

  const _RankingList({required this.ranking});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = context.loc;

    if (ranking.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withValues(alpha: 0.94),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.colorScheme.outlineVariant),
        ),
        child: Text(loc.result_noRanking, style: theme.textTheme.bodyMedium),
      );
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.bar_chart, size: 20),
              const SizedBox(width: 6),
              Text(
                loc.decision_editor_ranking,
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...ranking.asMap().entries.map((entry) {
            final index = entry.key + 1;
            final item = entry.value;

            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.6,
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: theme.colorScheme.outlineVariant),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: index == 1
                        ? Colors.green
                        : theme.colorScheme.primary,
                    child: Text(
                      '$index',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(item.label, style: theme.textTheme.titleMedium),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    item.score.toStringAsFixed(3),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _MetaChips extends StatelessWidget {
  final Decision decision;

  const _MetaChips({required this.decision});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        Chip(
          avatar: const Icon(Icons.ballot_outlined, size: 18),
          label: Text('${decision.options.length} options'),
          backgroundColor: theme.colorScheme.surface.withValues(alpha: 0.9),
        ),
        Chip(
          avatar: const Icon(Icons.analytics_outlined, size: 18),
          label: Text('${decision.criteria.length} criteria'),
          backgroundColor: theme.colorScheme.surface.withValues(alpha: 0.9),
        ),
        Chip(
          avatar: const Icon(Icons.calendar_today, size: 16),
          label: Text(
            (decision.updatedAt ?? decision.createdAt ?? DateTime.now())
                .toLocal()
                .toString(),
          ),
          backgroundColor: theme.colorScheme.surface.withValues(alpha: 0.9),
        ),
      ],
    );
  }
}

class _DebugCard extends StatelessWidget {
  final Map<String, dynamic> debug;

  const _DebugCard({required this.debug});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.bug_report_outlined, size: 20),
              const SizedBox(width: 6),
              Text(
                context.loc.result_debugData,
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...debug.entries.map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(
                '${e.key}: ${e.value}',
                style: theme.textTheme.bodySmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
