import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:thinkr/core/extensions/context_extension.dart';
import 'package:thinkr/core/widgets/top_snackbar.dart';
import 'package:thinkr/features/decision/domain/entities/decision.dart';
import 'package:thinkr/features/decision/domain/usecases/evaluate_decision_usecase.dart';
import 'package:thinkr/features/decision/domain/usecases/save_decision_usecase.dart';
import 'package:thinkr/l10n/app_localizations.dart';

import 'decision_editor_cubit.dart';
import 'decision_editor_state.dart';

class DecisionEditorPage extends StatelessWidget {
  final Decision? initialDecision;

  const DecisionEditorPage({super.key, this.initialDecision});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DecisionEditorCubit>(
      create: (_) {
        final cubit = DecisionEditorCubit(
          GetIt.I<EvaluateDecisionUseCase>(),
          GetIt.I<SaveDecisionUseCase>(),
        );
        if (initialDecision != null) {
          cubit.loadExisting(initialDecision!);
        } else {
          cubit.startNew();
        }
        return cubit;
      },
      child: const _DecisionEditorView(),
    );
  }
}

class _DecisionEditorView extends StatefulWidget {
  const _DecisionEditorView();

  @override
  State<_DecisionEditorView> createState() => _DecisionEditorViewState();
}

class _DecisionEditorViewState extends State<_DecisionEditorView> {
  int _currentStep = 0;
  final _titleFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _optionDraftFocus = FocusNode();
  final _criterionDraftFocus = FocusNode();
  final Map<String, FocusNode> _optionFocus = {};
  final Map<String, FocusNode> _criterionFocus = {};
  final Map<String, FocusNode> _scoreFocus = {};

  // ignore: unused_field
  final Map<String, String> _optionText = {};
  // ignore: unused_field
  final Map<String, String> _criterionText = {};
  // ignore: unused_field
  final Map<String, String> _scoreText = {};
  String? _titleText;
  String? _descriptionText;
  String? _optionDraftText;
  String? _criterionDraftText;
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  Future<bool> _confirmDiscardChanges(AppLocalizations loc) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(loc.decision_editor_title),
        content: Text(
          'You have unsaved changes. Leave the editor? Your input will be lost.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(MaterialLocalizations.of(dialogContext).cancelButtonLabel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(MaterialLocalizations.of(dialogContext).okButtonLabel),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    _optionDraftFocus.dispose();
    _criterionDraftFocus.dispose();
    for (final n in _optionFocus.values) {
      n.dispose();
    }
    for (final n in _criterionFocus.values) {
      n.dispose();
    }
    for (final n in _scoreFocus.values) {
      n.dispose();
    }
    super.dispose();
  }

  String _cacheSingle(String? current, String incoming, FocusNode focus) {
    if (!focus.hasFocus) {
      return incoming;
    }
    return current ?? incoming;
  }

  bool _isValidScore(double value) => value >= 1 && value <= 10;

  void _showScoreError(AppLocalizations loc) {
    showTopSnackBar(context, loc.decision_editor_scoreRange, isError: true);
  }

  void _handleScoreChange({
    required String raw,
    required OptionId optionId,
    required CriterionId criterionId,
    required AppLocalizations loc,
  }) {
    final parsed = double.tryParse(raw);
    if (parsed == null) return;
    if (!_isValidScore(parsed)) {
      _showScoreError(loc);
      return;
    }
    context.read<DecisionEditorCubit>().setScore(
          optionId: optionId,
          criterionId: criterionId,
          score: parsed,
        );
  }

  Future<void> _evaluate(BuildContext context, Decision decision) async {
    if (decision.options.isEmpty || decision.criteria.isEmpty) {
      showTopSnackBar(
        context,
        context.loc.decision_editor_scoresEmpty,
        isError: true,
      );
      return;
    }

    final cubit = context.read<DecisionEditorCubit>();
    final loc = context.loc;

    final confirmed =
        await showDialog<bool>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: [
                const Icon(Icons.auto_fix_high, color: Colors.amber),
                const SizedBox(width: 8),
                Text(loc.decision_editor_title),
              ],
            ),
            content: Text(loc.decision_editor_subtitle),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: Text(
                  MaterialLocalizations.of(dialogContext).cancelButtonLabel,
                ),
              ),
              FilledButton.icon(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                icon: const Icon(Icons.play_arrow),
                label: Text(loc.decision_editor_evaluate),
              ),
            ],
          ),
        ) ??
        false;

    if (!confirmed) return;

    await cubit.evaluate();
    if (!context.mounted) return;
    final updated = cubit.state.decision;
    if (updated?.result != null) {
      await context.push('/app/decisions/result', extra: updated);
    }
  }

  Widget _buildStepper(
    AppLocalizations loc,
    Decision decision,
    DecisionEditorState state,
    int missingScores,
  ) {
    final theme = Theme.of(context);
    final titleComplete = decision.title.trim().isNotEmpty;
    final optionsComplete = decision.options.length >= 2;
    final criteriaComplete = decision.criteria.isNotEmpty;
    final scoresComplete = state.canEvaluate && missingScores == 0;
    if (!_titleFocus.hasFocus && _titleController.text != decision.title) {
      _titleController.text = decision.title;
    }
    final descriptionText = decision.description ?? '';
    if (!_descriptionFocus.hasFocus &&
        _descriptionController.text != descriptionText) {
      _descriptionController.text = descriptionText;
    }
    final steps = [
      _EditorStep(
        title: loc.decision_editor_titleLabel,
        subtitle: loc.decision_editor_titleHint,
        builder: () => _buildTitleCard(loc, decision),
        isComplete: titleComplete,
      ),
      _EditorStep(
        title: loc.decision_editor_optionsTitle,
        subtitle: loc.decision_editor_optionsDescription,
        builder: () => _buildOptionsCard(loc, decision, state),
        isComplete: optionsComplete,
      ),
      _EditorStep(
        title: loc.decision_editor_criteriaTitle,
        subtitle: loc.decision_editor_criteriaDescription,
        builder: () => _buildCriteriaCard(loc, decision, state),
        isComplete: criteriaComplete,
      ),
      _EditorStep(
        title: loc.decision_editor_scoresTitle,
        subtitle: loc.decision_editor_scoresDescription,
        builder: () => _buildScoreMatrix(loc, decision, missingScores),
        isComplete: scoresComplete,
      ),
    ];

    _currentStep = _currentStep.clamp(0, steps.length - 1);
    final current = steps[_currentStep];
    final currentComplete = current.isComplete;
    final allComplete = steps.every((s) => s.isComplete);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(steps.length, (index) {
                final step = steps[index];
                final isActive = index == _currentStep;
                final allPrevComplete = steps
                    .take(index)
                    .every((s) => s.isComplete);
                final isComplete = step.isComplete && allPrevComplete;
                final color = isComplete
                    ? theme.colorScheme.primary
                    : theme.colorScheme.outlineVariant;

                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    selected: isActive,
                    onSelected: (allPrevComplete || index <= _currentStep)
                        ? (_) => setState(() => _currentStep = index)
                        : null,
                    avatar: CircleAvatar(
                      radius: 10,
                      backgroundColor: color,
                      child: Text(
                        '${index + 1}',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    label: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(step.title),
                        Text(
                          step.subtitle,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    shape: StadiumBorder(side: BorderSide(color: color)),
                    backgroundColor: theme.colorScheme.surfaceContainerHighest
                        .withValues(alpha: 0.4),
                  ),
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 12),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: Container(
            key: ValueKey(_currentStep),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface.withValues(alpha: 0.94),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: theme.colorScheme.outlineVariant),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: current.builder(),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            OutlinedButton.icon(
              onPressed: _currentStep > 0
                  ? () => setState(() => _currentStep -= 1)
                  : null,
              icon: const Icon(Icons.chevron_left),
              label: Text(MaterialLocalizations.of(context).backButtonTooltip),
            ),
            const Spacer(),
            FilledButton.icon(
              onPressed: _currentStep < steps.length - 1
                  ? (currentComplete
                        ? () => setState(() => _currentStep += 1)
                        : null)
                  : (allComplete ? () => _evaluate(context, decision) : null),
              icon: Icon(
                _currentStep < steps.length - 1
                    ? Icons.chevron_right
                    : Icons.auto_graph,
              ),
              label: Text(
                _currentStep < steps.length - 1
                    ? loc.decision_editor_stepEvaluate
                    : loc.decision_editor_evaluate,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;

    return MultiBlocListener(
      listeners: [
        BlocListener<DecisionEditorCubit, DecisionEditorState>(
          listenWhen: (prev, curr) =>
              prev.errorMessage != curr.errorMessage &&
              (curr.errorMessage?.isNotEmpty ?? false),
          listener: (context, state) {
            if (state.errorMessage != null) {
              showTopSnackBar(context, state.errorMessage!, isError: true);
            }
          },
        ),
        BlocListener<DecisionEditorCubit, DecisionEditorState>(
          listenWhen: (prev, curr) =>
              prev.isSaving && !curr.isSaving && curr.errorMessage == null,
          listener: (context, state) {
            showTopSnackBar(context, loc.decision_editor_saved);
          },
        ),
      ],
      child: BlocBuilder<DecisionEditorCubit, DecisionEditorState>(
        builder: (context, state) {
          final decision = state.decision ?? Decision.empty;

          _titleText = _cacheSingle(_titleText, decision.title, _titleFocus);
          _descriptionText = _cacheSingle(
            _descriptionText,
            decision.description ?? '',
            _descriptionFocus,
          );
          _optionDraftText = _cacheSingle(
            _optionDraftText,
            state.optionDraft,
            _optionDraftFocus,
          );
          _criterionDraftText = _cacheSingle(
            _criterionDraftText,
            state.criterionDraft,
            _criterionDraftFocus,
          );

          final completionPercent = state.completionPercent;
          final missingScores = state.missingScores;
          final validationMessages = <String>[
            if (!state.hasMinOptions) loc.decision_editor_validationOptions,
            if (!state.hasCriteria) loc.decision_editor_validationCriteria,
            if (missingScores > 0)
              loc.decision_editor_validationScores(missingScores),
          ];
          final primaryValidationMessage = validationMessages.isNotEmpty
              ? validationMessages.first
              : null;
          final isEvaluating = state.isLoading;
          final statusMessage =
              primaryValidationMessage ??
              (state.isEvaluated
                  ? loc.decision_editor_evaluatedChip
                  : loc.decision_editor_subtitle);

          return PopScope(
            canPop: !state.isDirty,
            onPopInvokedWithResult: (didPop, result) async {
              if (didPop) return;
              final navigator = Navigator.of(context);
              if (!state.isDirty) {
                if (mounted) navigator.maybePop(result);
                return;
              }
              final leave = await _confirmDiscardChanges(loc);
              if (!leave) return;
              if (!mounted) return;
              navigator.maybePop(result);
            },
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () async {
                    final navigator = Navigator.of(context);
                    final router = GoRouter.of(context);
                    final canPop = navigator.canPop();
                    if (state.isDirty) {
                      final leave = await _confirmDiscardChanges(loc);
                      if (!leave || !mounted) return;
                    }
                    if (!mounted) return;
                    if (canPop) {
                      navigator.pop();
                    } else {
                      router.go('/app/home');
                    }
                  },
                ),
                title: Text(loc.decision_editor_title),
              ),
              body: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF0F172A), Color(0xFF111827)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  Positioned(
                    top: -120,
                    left: -60,
                    child: Container(
                      width: 260,
                      height: 260,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.12),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.25),
                            blurRadius: 140,
                            spreadRadius: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -140,
                    right: -80,
                    child: Container(
                      width: 320,
                      height: 320,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(
                          context,
                        ).colorScheme.secondary.withValues(alpha: 0.12),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(
                              context,
                            ).colorScheme.secondary.withValues(alpha: 0.22),
                            blurRadius: 160,
                            spreadRadius: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.fromLTRB(16, 12, 16, 120),
                            child: Center(
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(maxWidth: 1100),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    const SizedBox(height: 4),
                                    _CompactHero(
                                      isEvaluated: state.isEvaluated,
                                      completionPercent: completionPercent,
                                      primaryValidationMessage:
                                          primaryValidationMessage,
                                      stats: _buildStats(decision),
                                    ),
                                    const SizedBox(height: 10),
                                    _buildValidationPills(validationMessages),
                                    if (state.errorMessage != null)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: _buildErrorBanner(
                                          state.errorMessage!,
                                        ),
                                      ),
                                    const SizedBox(height: 12),
                                    _buildTemplates(loc),
                                    const SizedBox(height: 16),
                                    _buildStepper(
                                      loc,
                                      decision,
                                      state,
                                      missingScores,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        _ActionBar(
                          isEvaluating: isEvaluating,
                          isSaving: state.isSaving,
                          statusMessage: statusMessage,
                          completionPercent: completionPercent,
                        ),
                      ],
                    ),
                  ),
                  if (state.isSaving || state.isLoading)
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: LinearProgressIndicator(
                        minHeight: 3,
                        color: state.isSaving
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStats(Decision decision) {
    final loc = context.loc;
    final theme = Theme.of(context);

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _statTile(
          label: loc.decision_editor_optionsTitle,
          value: decision.options.length.toString(),
          icon: Icons.ballot_outlined,
          theme: theme,
        ),
        _statTile(
          label: loc.decision_editor_criteriaTitle,
          value: decision.criteria.length.toString(),
          icon: Icons.analytics_outlined,
          theme: theme,
        ),
        _statTile(
          label: loc.decision_editor_scoresTitle,
          value: decision.scores.length.toString(),
          icon: Icons.grid_on,
          theme: theme,
        ),
      ],
    );
  }

  Widget _statTile({
    required String label,
    required String value,
    required IconData icon,
    required ThemeData theme,
  }) {
    final bg = theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.7);
    final onBg = theme.colorScheme.onSurface;
    final accent = theme.colorScheme.primary;

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 180, maxWidth: 240),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: theme.colorScheme.outlineVariant),
        ),
        child: Row(
          children: [
            Icon(icon, color: accent, size: 22),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: onBg.withValues(alpha: 0.7),
                  ),
                ),
                Text(
                  value,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: onBg,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValidationPills(List<String> messages) {
    if (messages.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: messages
          .map(
            (message) => Chip(
              avatar: const Icon(Icons.error_outline, size: 18),
              label: Text(message),
              backgroundColor: Colors.orange.withValues(alpha: 0.15),
              shape: StadiumBorder(
                side: BorderSide(color: Colors.orange.withValues(alpha: 0.5)),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildErrorBanner(String message) {
    final theme = Theme.of(context);

    return Card(
      color: Colors.red.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: theme.colorScheme.error),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTemplates(AppLocalizations loc) {
    final templates = _DecisionTemplates.presets(loc);

    return _sectionCard(
      title: loc.decision_editor_templatesTitle,
      description: loc.decision_editor_templatesDescription,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: templates
            .map(
              (template) => ActionChip(
                avatar: const Icon(Icons.auto_fix_high, size: 18),
                label: Text(template.name),
                tooltip: template.description,
                onPressed: () {
                  final decision = _DecisionTemplates.materialize(template);
                  context.read<DecisionEditorCubit>().applyTemplate(decision);
                  showTopSnackBar(
                    context,
                    loc.decision_editor_templateApplied(template.name),
                  );
                },
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildTitleCard(AppLocalizations loc, Decision decision) {
    return _sectionCard(
      title: loc.decision_editor_titleLabel,
      description: loc.decision_editor_titleHint,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMethodSelector(loc, decision),
          const SizedBox(height: 12),
          TextFormField(
            controller: _titleController,
            focusNode: _titleFocus,
            onChanged: (value) {
              context.read<DecisionEditorCubit>().setTitle(value);
            },
            decoration: InputDecoration(
              hintText: loc.decision_editor_titleHint,
              border: const OutlineInputBorder(),
            ),
            textCapitalization: TextCapitalization.sentences,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _descriptionController,
            focusNode: _descriptionFocus,
            onChanged: (value) {
              context.read<DecisionEditorCubit>().setDescription(value);
            },
            decoration: InputDecoration(
              labelText: loc.decision_editor_descriptionLabel,
              hintText: loc.decision_editor_descriptionHint,
              border: const OutlineInputBorder(),
            ),
            minLines: 2,
            maxLines: 3,
            textCapitalization: TextCapitalization.sentences,
          ),
        ],
      ),
    );
  }

  Widget _buildMethodSelector(AppLocalizations loc, Decision decision) {
    final theme = Theme.of(context);
    final methods = DecisionMethod.values;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          loc.decision_editor_methodLabel,
          style: theme.textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: methods.map((m) {
            final selected = decision.method == m;
            return ChoiceChip(
              label: Text(_methodLabel(loc, m)),
              selected: selected,
              onSelected: (_) {
                context.read<DecisionEditorCubit>().setMethod(m);
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  String _methodLabel(AppLocalizations loc, DecisionMethod method) {
    switch (method) {
      case DecisionMethod.weightedSum:
        return loc.decision_editor_methodWeighted;
      case DecisionMethod.ahp:
        return loc.decision_editor_methodAhp;
      case DecisionMethod.fuzzyWeightedSum:
        return loc.decision_editor_methodFuzzy;
    }
  }

  Widget _buildOptionsCard(
    AppLocalizations loc,
    Decision decision,
    DecisionEditorState state,
  ) {
    final theme = Theme.of(context);

    return _sectionCard(
      title: loc.decision_editor_optionsTitle,
      description: loc.decision_editor_optionsDescription,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  key: ValueKey('option-draft-${state.optionDraft.hashCode}'),
                  initialValue: state.optionDraft,
                  onChanged: (value) {
                    context.read<DecisionEditorCubit>().updateOptionDraft(
                      value,
                    );
                  },
                  onFieldSubmitted: (_) {
                    context.read<DecisionEditorCubit>().addDraftOption();
                  },
                  decoration: InputDecoration(
                    labelText: loc.decision_editor_optionHint,
                    hintText: loc.decision_editor_optionHint,
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () {
                  context.read<DecisionEditorCubit>().addDraftOption();
                },
                icon: const Icon(Icons.add),
                label: Text(loc.decision_editor_addOption),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (decision.options.isEmpty)
            Text(
              loc.decision_editor_noOptions,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            )
          else
            Column(
              children: decision.options
                  .map(
                    (option) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest
                            .withValues(alpha: 0.35),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: theme.colorScheme.outlineVariant,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              key: ValueKey('option-${option.id}'),
                              initialValue: option.label,
                              onChanged: (value) {
                                context
                                    .read<DecisionEditorCubit>()
                                    .renameOption(option.id, value);
                              },
                              decoration: InputDecoration(
                                labelText: loc.decision_editor_optionLabel,
                                isDense: true,
                                border: const OutlineInputBorder(),
                              ),
                              textCapitalization: TextCapitalization.sentences,
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: () {
                              context.read<DecisionEditorCubit>().removeOption(
                                option.id,
                              );
                            },
                            icon: const Icon(Icons.delete_outline),
                            tooltip: loc.decision_editor_remove,
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildCriteriaCard(
    AppLocalizations loc,
    Decision decision,
    DecisionEditorState state,
  ) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 640;

        Widget inputRow() {
          final textField = TextFormField(
            key: ValueKey('criterion-draft-${state.criterionDraft.hashCode}'),
            initialValue: state.criterionDraft,
            onChanged: (value) {
              context.read<DecisionEditorCubit>().updateCriterionDraft(value);
            },
            onFieldSubmitted: (_) {
              context.read<DecisionEditorCubit>().addDraftCriterion();
            },
            decoration: InputDecoration(
              labelText: loc.decision_editor_criterionHint,
              hintText: loc.decision_editor_criterionHint,
              border: const OutlineInputBorder(),
            ),
          );

          final weightSlider = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${loc.decision_editor_weightLabel}: '
                '${state.criterionWeightDraft.toStringAsFixed(1)}',
                style: theme.textTheme.bodyMedium,
              ),
              Slider(
                min: 0.1,
                max: 10,
                divisions: 99,
                value: state.criterionWeightDraft,
                onChanged: (value) {
                  context
                      .read<DecisionEditorCubit>()
                      .updateCriterionWeightDraft(value);
                },
              ),
            ],
          );

          final addButton = ElevatedButton.icon(
            onPressed: () {
              context.read<DecisionEditorCubit>().addDraftCriterion();
            },
            icon: const Icon(Icons.add_chart),
            label: Text(loc.decision_editor_addCriterion),
          );

          if (isNarrow) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textField,
                const SizedBox(height: 12),
                weightSlider,
                const SizedBox(height: 12),
                addButton,
              ],
            );
          }

          return Row(
            children: [
              Expanded(child: textField),
              const SizedBox(width: 12),
              Expanded(flex: 2, child: weightSlider),
              const SizedBox(width: 12),
              Flexible(child: addButton),
            ],
          );
        }

        return _sectionCard(
          title: loc.decision_editor_criteriaTitle,
          description: loc.decision_editor_criteriaDescription,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              inputRow(),
              const SizedBox(height: 8),
              Text(
                loc.decision_editor_weightsNote,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 12),
              if (decision.criteria.isEmpty)
                Text(
                  loc.decision_editor_noCriteria,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                )
              else
                Column(
                  children: decision.criteria
                      .map(
                        (criterion) => Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest
                                .withValues(alpha: 0.35),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: theme.colorScheme.outlineVariant,
                            ),
                          ),
                          child: LayoutBuilder(
                            builder: (context, innerConstraints) {
                              final dense = innerConstraints.maxWidth < 520;

                              final field = TextFormField(
                                key: ValueKey('criterion-${criterion.id}'),
                                initialValue: criterion.label,
                                onChanged: (value) {
                                  context
                                      .read<DecisionEditorCubit>()
                                      .renameCriterion(criterion.id, value);
                                },
                                decoration: InputDecoration(
                                  labelText: loc.decision_editor_criterionLabel,
                                  isDense: true,
                                  border: const OutlineInputBorder(),
                                ),
                                textCapitalization:
                                    TextCapitalization.sentences,
                              );

                              final weight = Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Slider(
                                    min: 0.1,
                                    max: 10,
                                    divisions: 99,
                                    value: criterion.weight
                                        .clamp(0.1, 10)
                                        .toDouble(),
                                    label: criterion.weight.toStringAsFixed(1),
                                    onChanged: (value) {
                                      context
                                          .read<DecisionEditorCubit>()
                                          .setCriterionWeight(
                                            criterion.id,
                                            value,
                                          );
                                    },
                                  ),
                                  Text(
                                    '${loc.decision_editor_weightLabel}: ${criterion.weight.toStringAsFixed(1)}',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              );

                              final removeButton = FilledButton.tonalIcon(
                                style: FilledButton.styleFrom(
                                  backgroundColor: Colors.red.withValues(
                                    alpha: 0.12,
                                  ),
                                  foregroundColor: Colors.red.shade700,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                    horizontal: 12,
                                  ),
                                ),
                                onPressed: () {
                                  context
                                      .read<DecisionEditorCubit>()
                                      .removeCriterion(criterion.id);
                                },
                                icon: const Icon(Icons.delete_outline),
                                label: Text(loc.decision_editor_remove),
                              );

                              if (dense) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    field,
                                    const SizedBox(height: 6),
                                    weight,
                                    const SizedBox(height: 6),
                                    SizedBox(
                                      width: double.infinity,
                                      child: removeButton,
                                    ),
                                  ],
                                );
                              }

                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: field),
                                  const SizedBox(width: 12),
                                  Expanded(flex: 2, child: weight),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: removeButton,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      )
                      .toList(),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildScoreMatrix(
    AppLocalizations loc,
    Decision decision,
    int missingScores,
  ) {
    final theme = Theme.of(context);
    final isCompact = MediaQuery.of(context).size.width < 720;

    if (decision.options.isEmpty || decision.criteria.isEmpty) {
      return _sectionCard(
        title: loc.decision_editor_scoresTitle,
        description: loc.decision_editor_scoresDescription,
        child: Text(
          loc.decision_editor_scoresEmpty,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    return _sectionCard(
      title: loc.decision_editor_scoresTitle,
      description: loc.decision_editor_scoresDescription,
      child: isCompact
          ? _buildScoreCards(loc, decision, missingScores)
          : _buildScoreTable(loc, decision, missingScores),
    );
  }

  Widget _buildScoreTable(
    AppLocalizations loc,
    Decision decision,
    int missingScores,
  ) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (missingScores > 0) ...[
            Text(
              loc.decision_editor_validationScores(missingScores),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
            const SizedBox(height: 8),
          ],
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: theme.colorScheme.outlineVariant),
            ),
            child: DataTable(
              horizontalMargin: 16,
              columnSpacing: 20,
              headingRowHeight: 60,
              headingRowColor: WidgetStateProperty.all(
                theme.colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.4,
                ),
              ),
              columns: [
                DataColumn(
                  label: Text(
                    loc.decision_editor_scoreOptionHeader,
                    style: theme.textTheme.titleSmall,
                  ),
                ),
                ...decision.criteria.map(
                  (criterion) => DataColumn(
                    label: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          criterion.label,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${loc.decision_editor_weightLabel} '
                          '${criterion.weight.toStringAsFixed(1)}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              rows: decision.options
                  .map(
                    (option) => DataRow(
                      cells: [
                        DataCell(
                          Text(option.label, style: theme.textTheme.bodyMedium),
                        ),
                        ...decision.criteria.map((criterion) {
                          final key = '${option.id}|${criterion.id}';
                          final scoreValue = decision.scores[key];

                          return DataCell(
                            SizedBox(
                              width: 104,
                              child: TextFormField(
                                key: ValueKey(key),
                                initialValue: scoreValue != null
                                    ? '$scoreValue'
                                    : '',
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  hintText:
                                      loc.decision_editor_scorePlaceholder,
                                  isDense: true,
                                  border: const OutlineInputBorder(),
                                ),
                                onChanged: (value) => _handleScoreChange(
                                  raw: value,
                                  optionId: option.id,
                                  criterionId: criterion.id,
                                  loc: loc,
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            loc.decision_editor_scoreHint,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          if (missingScores > 0) ...[
            const SizedBox(height: 4),
            Text(
              loc.decision_editor_scoreDefaultZero,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildScoreCards(
    AppLocalizations loc,
    Decision decision,
    int missingScores,
  ) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (missingScores > 0) ...[
          Text(
            loc.decision_editor_validationScores(missingScores),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
          const SizedBox(height: 8),
        ],
        ...decision.options.map(
          (option) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.35,
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: theme.colorScheme.outlineVariant),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        option.label,
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.checklist,
                            size: 16,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${decision.criteria.length} ${loc.decision_editor_criteriaTitle.toLowerCase()}',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...decision.criteria.map((criterion) {
                  final key = '${option.id}|${criterion.id}';
                  final scoreValue = decision.scores[key];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: theme.colorScheme.outlineVariant,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                criterion.label,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Chip(
                                    label: Text(
                                      '${loc.decision_editor_weightLabel} ${criterion.weight.toStringAsFixed(1)}',
                                    ),
                                    padding: EdgeInsets.zero,
                                    shape: const StadiumBorder(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 96,
                          child: TextFormField(
                            key: ValueKey(key),
                            initialValue: scoreValue != null
                                ? '$scoreValue'
                                : '',
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              labelText: loc.decision_editor_scorePlaceholder,
                              isDense: true,
                              border: const OutlineInputBorder(),
                            ),
                            onChanged: (value) => _handleScoreChange(
                              raw: value,
                              optionId: option.id,
                              criterionId: criterion.id,
                              loc: loc,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
        Text(
          loc.decision_editor_scoreHint,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        if (missingScores > 0) ...[
          const SizedBox(height: 4),
          Text(
            loc.decision_editor_scoreDefaultZero,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }

  Widget _sectionCard({
    required String title,
    String? description,
    required Widget child,
  }) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: theme.colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.titleMedium),
            if (description != null) ...[
              const SizedBox(height: 4),
              Text(
                description,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class _ActionBar extends StatelessWidget {
  final bool isEvaluating;
  final bool isSaving;
  final String statusMessage;
  final int completionPercent;

  const _ActionBar({
    required this.isEvaluating,
    required this.isSaving,
    required this.statusMessage,
    required this.completionPercent,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusSection = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          statusMessage,
          style: theme.textTheme.titleSmall,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            SizedBox(
              width: 120,
              child: LinearProgressIndicator(
                value: completionPercent / 100,
                minHeight: 6,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '$completionPercent%',
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.96),
        border: Border(
          top: BorderSide(color: theme.colorScheme.outlineVariant),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: statusSection,
            ),
          ),
        ),
      ),
    );
  }
}

class _CompactHero extends StatefulWidget {
  final bool isEvaluated;
  final int completionPercent;
  final String? primaryValidationMessage;
  final Widget stats;

  const _CompactHero({
    required this.isEvaluated,
    required this.completionPercent,
    required this.primaryValidationMessage,
    required this.stats,
  });

  @override
  State<_CompactHero> createState() => _CompactHeroState();
}

class _CompactHeroState extends State<_CompactHero> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = context.loc;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ExpansionTile(
        initiallyExpanded: false,
        tilePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        onExpansionChanged: (val) => setState(() => _expanded = val),
        title: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc.decision_editor_title,
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.primaryValidationMessage ??
                        loc.decision_editor_subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            if (widget.isEvaluated)
              Chip(
                visualDensity: VisualDensity.compact,
                avatar: const Icon(Icons.check_circle, color: Colors.green),
                label: Text(loc.decision_editor_evaluatedChip),
                backgroundColor: Colors.green.withValues(alpha: 0.1),
                shape: StadiumBorder(
                  side: BorderSide(color: Colors.green.withValues(alpha: 0.3)),
                ),
              ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8, right: 8),
          child: Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: widget.completionPercent / 100,
                    minHeight: 8,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${widget.completionPercent}%',
                style: theme.textTheme.labelLarge,
              ),
            ],
          ),
        ),
        trailing: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
        children: [
          Wrap(spacing: 12, runSpacing: 12, children: [widget.stats]),
        ],
      ),
    );
  }
}

class _CriterionTemplate {
  final String label;
  final double weight;

  const _CriterionTemplate(this.label, this.weight);
}

class _DecisionTemplate {
  final String name;
  final String title;
  final String? description;
  final List<String> options;
  final List<_CriterionTemplate> criteria;

  const _DecisionTemplate({
    required this.name,
    required this.title,
    this.description,
    required this.options,
    required this.criteria,
  });
}

abstract class _DecisionTemplates {
  static List<_DecisionTemplate> presets(AppLocalizations loc) => [
    _DecisionTemplate(
      name: loc.decision_editor_templateCareer,
      title: loc.decision_editor_templateCareer,
      description: loc.decision_editor_templateCareerDesc,
      options: [
        loc.decision_editor_templateCareer_optionStay,
        loc.decision_editor_templateCareer_optionNewCompany,
        loc.decision_editor_templateCareer_optionFreelance,
      ],
      criteria: [
        _CriterionTemplate(loc.decision_editor_templateCareer_critComp, 3.5),
        _CriterionTemplate(loc.decision_editor_templateCareer_critGrowth, 3.0),
        _CriterionTemplate(loc.decision_editor_templateCareer_critBalance, 2.0),
        _CriterionTemplate(
          loc.decision_editor_templateCareer_critStability,
          1.0,
        ),
      ],
    ),
    _DecisionTemplate(
      name: loc.decision_editor_templateProduct,
      title: loc.decision_editor_templateProduct,
      description: loc.decision_editor_templateProductDesc,
      options: [
        loc.decision_editor_templateProduct_optionSaas,
        loc.decision_editor_templateProduct_optionBuild,
        loc.decision_editor_templateProduct_optionOpenSource,
      ],
      criteria: [
        _CriterionTemplate(loc.decision_editor_templateProduct_critCost, 3.0),
        _CriterionTemplate(loc.decision_editor_templateProduct_critSpeed, 2.5),
        _CriterionTemplate(
          loc.decision_editor_templateProduct_critScalability,
          2.0,
        ),
        _CriterionTemplate(
          loc.decision_editor_templateProduct_critSupport,
          1.5,
        ),
      ],
    ),
    _DecisionTemplate(
      name: loc.decision_editor_templateTravel,
      title: loc.decision_editor_templateTravel,
      description: loc.decision_editor_templateTravelDesc,
      options: [
        loc.decision_editor_templateTravel_optionBeach,
        loc.decision_editor_templateTravel_optionCity,
        loc.decision_editor_templateTravel_optionNature,
      ],
      criteria: [
        _CriterionTemplate(loc.decision_editor_templateTravel_critBudget, 3.0),
        _CriterionTemplate(
          loc.decision_editor_templateTravel_critActivities,
          2.0,
        ),
        _CriterionTemplate(loc.decision_editor_templateTravel_critWeather, 1.5),
        _CriterionTemplate(
          loc.decision_editor_templateTravel_critTravelTime,
          1.0,
        ),
      ],
    ),
    _DecisionTemplate(
      name: loc.decision_editor_templateFinance,
      title: loc.decision_editor_templateFinance,
      description: loc.decision_editor_templateFinanceDesc,
      options: [
        loc.decision_editor_templateFinance_optionIndex,
        loc.decision_editor_templateFinance_optionRealEstate,
        loc.decision_editor_templateFinance_optionCash,
      ],
      criteria: [
        _CriterionTemplate(loc.decision_editor_templateFinance_critRisk, 3.0),
        _CriterionTemplate(loc.decision_editor_templateFinance_critReturn, 2.5),
        _CriterionTemplate(
          loc.decision_editor_templateFinance_critLiquidity,
          2.0,
        ),
        _CriterionTemplate(
          loc.decision_editor_templateFinance_critHorizon,
          1.5,
        ),
      ],
    ),
  ];

  static Decision materialize(_DecisionTemplate template) {
    final timestamp = DateTime.now().microsecondsSinceEpoch;

    return Decision(
      title: template.title,
      description: template.description,
      options: [
        for (var i = 0; i < template.options.length; i++)
          DecisionOption(id: 'opt-$timestamp-$i', label: template.options[i]),
      ],
      criteria: [
        for (var i = 0; i < template.criteria.length; i++)
          DecisionCriterion(
            id: 'crit-$timestamp-$i',
            label: template.criteria[i].label,
            weight: template.criteria[i].weight,
          ),
      ],
      scores: const {},
    );
  }
}

class _EditorStep {
  final String title;
  final String subtitle;
  final Widget Function() builder;
  final bool isComplete;

  const _EditorStep({
    required this.title,
    required this.subtitle,
    required this.builder,
    required this.isComplete,
  });
}
