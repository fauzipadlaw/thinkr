import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:thinkr/core/extensions/context_extension.dart';
import 'package:thinkr/core/theme/app_colors.dart';
import 'package:thinkr/core/widgets/top_snackbar.dart';

import 'package:thinkr/features/auth/presentation/auth_cubit.dart';
import 'package:thinkr/features/decision/domain/entities/decision.dart';
import 'package:thinkr/features/decision/presentation/history/decision_preview_cubit.dart';
import 'package:thinkr/l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;

    return Scaffold(
      body: Stack(
        children: [
          const _Background(),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    children: [
                  _Logo(loc: loc),
                  const Spacer(),
                  IconButton(
                    onPressed: () => context.go('/docs'),
                    icon: const Icon(Icons.menu_book_rounded, color: Colors.white),
                    tooltip: 'Docs',
                  ),
                  IconButton(
                    onPressed: () => context.go('/app/settings'),
                    icon: const Icon(Icons.language, color: Colors.white),
                    tooltip: loc.settings_title,
                  ),
                  IconButton(
                    onPressed: () async {
                          final confirmed = await showDialog<bool>(
                            context: context,
                            builder: (dialogContext) => AlertDialog(
                              title: Text(loc.login_signOut),
                              content: const Text(
                                'Are you sure you want to sign out?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(dialogContext).pop(false),
                                  child: Text(
                                    MaterialLocalizations.of(dialogContext)
                                        .cancelButtonLabel,
                                  ),
                                ),
                                FilledButton(
                                  onPressed: () =>
                                      Navigator.of(dialogContext).pop(true),
                                  child: Text(loc.login_signOut),
                                ),
                              ],
                            ),
                          );
                          if (confirmed == true && context.mounted) {
                            context.read<AuthCubit>().signOut();
                          }
                        },
                        icon: const Icon(Icons.logout, color: Colors.white),
                        tooltip: loc.login_signOut,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 720),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: BlocProvider<DecisionPreviewCubit>(
                            create: (_) =>
                                DecisionPreviewCubit(GetIt.I())..load(),
                            child: _HeroCard(loc: loc),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HistoryPreview extends StatelessWidget {
  const _HistoryPreview();

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    return BlocListener<DecisionPreviewCubit, DecisionPreviewState>(
      listenWhen: (prev, curr) =>
          prev.errorMessage != curr.errorMessage &&
          (curr.errorMessage?.isNotEmpty ?? false),
      listener: (context, state) {
        if (state.errorMessage != null) {
          showTopSnackBar(context, state.errorMessage!, isError: true);
        }
      },
      child: BlocBuilder<DecisionPreviewCubit, DecisionPreviewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: LinearProgressIndicator(minHeight: 3),
            );
          }

          if (state.errorMessage != null) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  loc.history_errorTitle,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      state.errorMessage!,
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () =>
                          context.read<DecisionPreviewCubit>().refresh(),
                      child: Text(loc.history_retry),
                    ),
                  ],
                ),
              ],
            );
          }

          if (state.decisions.isEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  loc.history_emptyTitle,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  loc.history_emptySubtitle,
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: _GhostButton(
                    label: loc.home_viewAllHistory,
                    icon: Icons.arrow_forward,
                    onTap: () => context.go('/app/history'),
                  ),
                ),
              ],
            );
          }

          final items = state.decisions.take(3).toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                loc.home_recentDecisions,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 10),
              ...items.map(
                (d) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _HistoryChip(
                    decision: d,
                    badge:
                        '${d.options.length} ${loc.history_options} • ${d.criteria.length} ${loc.history_criteria}',
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: _GhostButton(
                  label: loc.home_viewAllHistory,
                  icon: Icons.arrow_forward,
                  onTap: () => context.go('/app/history'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _HistoryChip extends StatelessWidget {
  final Decision decision;
  final String badge;

  const _HistoryChip({required this.decision, required this.badge});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    void goToDestination() {
      if (decision.result != null) {
        context.push('/app/decisions/result', extra: decision);
      } else {
        context.push('/app/decisions/edit', extra: decision);
      }
    }

    return InkWell(
      onTap: goToDestination,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              decision.title,
              style: theme.textTheme.titleSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (decision.description != null &&
                decision.description!.trim().isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                decision.description!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.white70,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            const SizedBox(height: 6),
            Text(
              badge,
              style: theme.textTheme.bodySmall?.copyWith(color: Colors.white60),
            ),
          ],
        ),
      ),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.bgDeep, AppColors.bgDark, AppColors.bgDarker],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Positioned.fill(child: CustomPaint(painter: _GlowPainter())),
      ],
    );
  }
}

class _GlowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 80);

    paint.color = AppColors.brandPrimary.withValues(alpha: 0.35);
    canvas.drawCircle(Offset(size.width * 0.25, size.height * 0.2), 140, paint);

    paint.color = AppColors.brandAccent.withValues(alpha: 0.25);
    canvas.drawCircle(
      Offset(size.width * 0.75, size.height * 0.25),
      160,
      paint,
    );

    paint.color = AppColors.brandPurple.withValues(alpha: 0.18);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.75), 220, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _Logo extends StatelessWidget {
  final AppLocalizations loc;

  const _Logo({required this.loc});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [AppColors.brandPrimary, AppColors.brandAccent],
              ),
              boxShadow: [
                BoxShadow(
                color: AppColors.brandPrimary.withValues(alpha: 0.4),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(Icons.bolt, color: Colors.white),
        ),
        const SizedBox(width: 10),
        Text(
          loc.appName,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
          ),
        ),
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  final AppLocalizations loc;

  const _HeroCard({required this.loc});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            loc.home_title,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            loc.decision_editor_subtitle,
            style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white70),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 480;
              return Flex(
                direction: isWide ? Axis.horizontal : Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _PrimaryButton(
                    label: loc.home_newDecision,
                    icon: Icons.add,
                    onTap: () => context.go('/app/decisions/new'),
                  ),
                  SizedBox(width: isWide ? 16 : 0, height: isWide ? 0 : 12),
                ],
              );
            },
          ),
          const SizedBox(height: 28),
          const _HistoryPreview(),
        ],
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _PrimaryButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.brandPrimary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 6,
        shadowColor: AppColors.brandPrimary.withValues(alpha: 0.5),
      ),
      icon: Icon(icon),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
    );
  }
}

class _GhostButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _GhostButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: BorderSide(color: Colors.white.withValues(alpha: 0.4)),
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      icon: Icon(icon),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}
