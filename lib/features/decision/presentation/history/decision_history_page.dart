import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:thinkr/core/extensions/context_extension.dart';
import 'package:thinkr/core/routes/app_routes.dart';
import 'package:thinkr/core/widgets/top_snackbar.dart';
import 'package:thinkr/features/decision/domain/entities/decision.dart';
import 'package:thinkr/features/decision/presentation/decision_result_page.dart';

import 'decision_history_cubit.dart';
import 'decision_history_state.dart';

class DecisionHistoryPage extends StatefulWidget {
  const DecisionHistoryPage({super.key});

  @override
  State<DecisionHistoryPage> createState() => _DecisionHistoryPageState();
}

class _DecisionHistoryPageState extends State<DecisionHistoryPage> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;

    return BlocProvider<DecisionHistoryCubit>(
      create: (_) => DecisionHistoryCubit(GetIt.I(), GetIt.I())..load(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go(AppRoutes.home);
              }
            },
          ),
          title: Text(loc.history_title),
        ),
        body: BlocConsumer<DecisionHistoryCubit, DecisionHistoryState>(
          listener: (context, state) {
            if (state.errorMessage != null) {
              showTopSnackBar(context, state.errorMessage!, isError: true);
            }
          },
          builder: (context, state) {
            if (_searchController.text != state.searchTerm) {
              _searchController.text = state.searchTerm;
            }

            if (state.isLoading && state.decisions.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.errorMessage != null && state.decisions.isEmpty) {
              return _EmptyState(
                icon: Icons.error_outline,
                title: loc.history_errorTitle,
                message: state.errorMessage!,
                actionLabel: loc.history_retry,
                onAction: () => context.read<DecisionHistoryCubit>().load(),
              );
            }

            if (state.decisions.isEmpty) {
              return _EmptyState(
                icon: Icons.history,
                title: loc.history_emptyTitle,
                message: loc.history_emptySubtitle,
                actionLabel: loc.history_newDecision,
                onAction: () => context.go(AppRoutes.decisionsNew),
              );
            }

            final isWeb = kIsWeb;

            Widget buildList(bool web) {
              final baseCount = state.decisions.length + 1; // search row
              final itemCount = web
                  ? baseCount
                  : baseCount + (state.hasMore ? 1 : 0);

              final listView = ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'Search title or description',
                          border: const OutlineInputBorder(),
                          isDense: true,
                        ),
                        onChanged: (value) => context
                            .read<DecisionHistoryCubit>()
                            .setSearchTerm(value),
                      ),
                    );
                  }

                  final listIndex = index - 1;

                  if (!web &&
                      state.hasMore &&
                      listIndex == state.decisions.length) {
                    context.read<DecisionHistoryCubit>().loadMore();
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final decision = state.decisions[listIndex];
                  return _DecisionCard(
                    decision: decision,
                    isDeleting: state.isDeleting,
                    onDelete: () => context.read<DecisionHistoryCubit>().delete(
                      decision.id!,
                    ),
                  );
                },
              );

              if (web) return listView;

              return RefreshIndicator(
                onRefresh: () => context.read<DecisionHistoryCubit>().refresh(),
                child: NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    if (notification.metrics.pixels >=
                            notification.metrics.maxScrollExtent - 120 &&
                        state.hasMore &&
                        !state.isLoadingMore &&
                        !kIsWeb) {
                      context.read<DecisionHistoryCubit>().loadMore();
                    }
                    return false;
                  },
                  child: listView,
                ),
              );
            }

            Widget list = buildList(isWeb);

            if (isWeb) {
              list = Column(
                children: [
                  Expanded(child: list),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          onPressed: state.page <= 0 || state.isLoading
                              ? null
                              : () => context
                                    .read<DecisionHistoryCubit>()
                                    .goToPage(state.page - 1),
                          child: const Text('Prev'),
                        ),
                        const SizedBox(width: 12),
                        Text('Page ${state.page + 1}'),
                        const SizedBox(width: 12),
                        OutlinedButton(
                          onPressed: (!state.hasMore || state.isLoading)
                              ? null
                              : () => context
                                    .read<DecisionHistoryCubit>()
                                    .goToPage(state.page + 1),
                          child: const Text('Next'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            return Stack(
              children: [
                list,
                if (state.isLoadingMore && isWeb)
                  const Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: LinearProgressIndicator(minHeight: 2),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _DecisionCard extends StatelessWidget {
  final Decision decision;
  final bool isDeleting;
  final VoidCallback onDelete;

  const _DecisionCard({
    required this.decision,
    required this.isDeleting,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final theme = Theme.of(context);
    final result = decision.result;
    void openResultOrEdit() {
      if (decision.result != null) {
        context.push(
          AppRoutes.decisionsResult,
          extra: DecisionResultArgs(decision: decision, fromEditor: false),
        );
      } else {
        context.push(AppRoutes.decisionsEdit, extra: decision);
      }
    }

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: openResultOrEdit,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      decision.title,
                      style: theme.textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    onPressed: isDeleting ? null : onDelete,
                    icon: isDeleting
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.delete_outline),
                    tooltip: loc.history_delete,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (decision.description != null &&
                  decision.description!.trim().isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    decision.description!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  Chip(
                    label: Text(
                      '${decision.options.length} ${loc.history_options}',
                    ),
                  ),
                  Chip(
                    label: Text(
                      '${decision.criteria.length} ${loc.history_criteria}',
                    ),
                  ),
                  if (result != null)
                    Chip(
                      avatar: const Icon(Icons.auto_awesome, size: 18),
                      label: Text(
                        loc.history_bestOption(
                          decision.options
                              .firstWhere(
                                (o) => o.id == result.bestOptionId,
                                orElse: () => decision.options.first,
                              )
                              .label,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  OutlinedButton.icon(
                    onPressed: openResultOrEdit,
                    icon: const Icon(Icons.open_in_new),
                    label: Text(loc.history_viewResult),
                  ),
                  FilledButton.icon(
                    onPressed: () =>
                        context.push(AppRoutes.decisionsEdit, extra: decision),
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String actionLabel;
  final VoidCallback onAction;

  const _EmptyState({
    required this.icon,
    required this.title,
    required this.message,
    required this.actionLabel,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(height: 12),
            Text(title, style: theme.textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: onAction, child: Text(actionLabel)),
          ],
        ),
      ),
    );
  }
}
