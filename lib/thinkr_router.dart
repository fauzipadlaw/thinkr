import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:thinkr/features/auth/presentation/login_page.dart';
import 'package:thinkr/features/home/presentation/home_page.dart';

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
        GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
        GoRoute(
          path: '/app/home',
          builder: (context, state) => const HomePage(),
        ),
      ],
      redirect: (context, state) {
        final loggedIn = authStateNotifier.isLoggedIn;
        final loggingIn = state.matchedLocation == '/login';

        if (!loggedIn && !loggingIn) {
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
