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

import 'features/auth/presentation/auth_state_notifier.dart';

@module
abstract class RouterModule {
  @lazySingleton
  GoRouter router(AuthStateNotifier authStateNotifier) {
    return GoRouter(
      initialLocation: '/',
      refreshListenable: authStateNotifier,
      routes: [
        GoRoute(
          path: '/',
          redirect: (context, state) =>
              authStateNotifier.isLoggedIn ? '/app/home' : '/login',
        ),
        GoRoute(
          path: '/docs',
          builder: (context, state) => const DocumentationPage(),
        ),
        GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
        GoRoute(
          path: '/app/home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/app/decisions/new',
          builder: (context, state) => const DecisionEditorPage(),
        ),
        GoRoute(
          path: '/app/history',
          builder: (context, state) => const DecisionHistoryPage(),
        ),
        GoRoute(
          path: '/app/settings',
          builder: (context, state) => const SettingsPage(),
        ),
        GoRoute(
          path: '/app/docs',
          builder: (context, state) => const DocumentationPage(),
        ),
        GoRoute(
          path: '/app/decisions/result',
          builder: (context, state) {
            final decision = state.extra as Decision?;
            if (decision == null) {
              return const HomePage();
            }
            return DecisionResultPage(decision: decision);
          },
        ),
        GoRoute(
          path: '/app/decisions/edit',
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
        final loggingIn = state.matchedLocation == '/login';
        final viewingDocs = state.matchedLocation == '/docs';

        if (!loggedIn && !loggingIn && !viewingDocs) {
          return '/login';
        }

        if (loggedIn && loggingIn) {
          return '/app/home';
        }

        return null;
      },
    );
  }
}
