import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:thinkr/features/decision/domain/entities/decision.dart';
import 'package:thinkr/features/auth/presentation/login_page.dart';
import 'package:thinkr/features/decision/presentation/decision_editor_page.dart';
import 'package:thinkr/features/decision/presentation/history/decision_history_page.dart';
import 'package:thinkr/features/decision/presentation/decision_result_page.dart';
import 'package:thinkr/features/home/presentation/home_page.dart';
import 'package:thinkr/features/settings/presentation/settings_page.dart';
import 'package:thinkr/features/documentation/presentation/documentation_page.dart';
import 'package:thinkr/core/routes/app_routes.dart';

import 'features/auth/presentation/auth_state_notifier.dart';

@module
abstract class RouterModule {
  @lazySingleton
  GoRouter router(AuthStateNotifier authStateNotifier) {
    return GoRouter(
      initialLocation: AppRoutes.root,
      refreshListenable: authStateNotifier,
      routes: [
        GoRoute(
          path: AppRoutes.root,
          redirect: (context, state) =>
              authStateNotifier.isLoggedIn ? AppRoutes.home : AppRoutes.login,
        ),
        GoRoute(
          path: AppRoutes.docsPublic,
          builder: (context, state) => const DocumentationPage(),
        ),
        GoRoute(
          path: AppRoutes.login,
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: AppRoutes.decisionsNew,
          builder: (context, state) => const DecisionEditorPage(),
        ),
        GoRoute(
          path: AppRoutes.history,
          builder: (context, state) => const DecisionHistoryPage(),
        ),
        GoRoute(
          path: AppRoutes.settings,
          builder: (context, state) => const SettingsPage(),
        ),
        GoRoute(
          path: AppRoutes.docs,
          builder: (context, state) => const DocumentationPage(),
        ),
        GoRoute(
          path: AppRoutes.decisionsResult,
          builder: (context, state) {
            final extra = state.extra;
            if (extra is DecisionResultArgs) {
              return DecisionResultPage(
                decision: extra.decision,
                fromEditor: extra.fromEditor,
              );
            }
            if (extra is Decision) {
              return DecisionResultPage(decision: extra, fromEditor: false);
            }
            return const HomePage();
          },
        ),
        GoRoute(
          path: AppRoutes.decisionsEdit,
          builder: (context, state) {
            final decision = state.extra as Decision?;
            if (decision == null) {
              return const DecisionEditorPage();
            }
            return DecisionEditorPage(initialDecision: decision);
          },
        ),
      ],
      redirect: (context, state) {
        final loggedIn = authStateNotifier.isLoggedIn;
        final loggingIn = state.matchedLocation == AppRoutes.login;
        final viewingDocs = state.matchedLocation == AppRoutes.docsPublic;

        if (!loggedIn && !loggingIn && !viewingDocs) {
          return AppRoutes.login;
        }

        if (loggedIn && loggingIn) {
          return AppRoutes.home;
        }

        return null;
      },
    );
  }
}
