import 'package:flutter_test/flutter_test.dart';
import 'package:thinkr/features/auth/domain/auth_user.dart';
import 'package:thinkr/features/auth/presentation/auth_cubit.dart';
import 'package:thinkr/features/auth/presentation/auth_state.dart';
import '../../../helpers/mock_auth_repository.dart';

void main() {
  late MockAuthRepository mockRepository;
  late AuthCubit cubit;

  setUp(() {
    mockRepository = MockAuthRepository();
    cubit = AuthCubit(mockRepository);
  });

  tearDown(() {
    cubit.close();
    mockRepository.dispose();
  });

  group('AuthCubit', () {
    test('initial state should be unknown', () {
      expect(cubit.state, equals(AuthState.initial));
      expect(cubit.state.isUnknown, isTrue);
      expect(cubit.state.isAuthenticated, isFalse);
      expect(cubit.state.user, isNull);
    });

    test('initialize with no user should set unauthenticated state', () async {
      await cubit.initialize();

      expect(cubit.state.isUnknown, isFalse);
      expect(cubit.state.isAuthenticated, isFalse);
      expect(cubit.state.user, isNull);
    });

    test('initialize with existing user should set authenticated state', () async {
      const user = AuthUser(id: 'user-123', email: 'test@example.com');
      mockRepository.setCurrentUser(user);

      await cubit.initialize();

      expect(cubit.state.isUnknown, isFalse);
      expect(cubit.state.isAuthenticated, isTrue);
      expect(cubit.state.user?.id, 'user-123');
      expect(cubit.state.user?.email, 'test@example.com');
    });

    test('should listen to auth state changes after initialization', () async {
      await cubit.initialize();

      const user = AuthUser(id: 'new-user', email: 'new@example.com');
      mockRepository.setCurrentUser(user);

      await Future.delayed(const Duration(milliseconds: 100));

      expect(cubit.state.isAuthenticated, isTrue);
      expect(cubit.state.user?.id, 'new-user');
    });

    test('signIn should authenticate user with Google', () async {
      await cubit.initialize();
      await cubit.signIn();

      expect(cubit.state.isAuthenticated, isTrue);
      expect(cubit.state.user?.email, 'test@google.com');
    });

    test('signIn should handle errors gracefully', () async {
      mockRepository.shouldThrowOnSignIn = true;
      mockRepository.errorMessage = 'Google sign-in failed';

      await cubit.initialize();

      expect(() => cubit.signIn(), throwsException);
    });

    test('signInWithEmail should authenticate user', () async {
      await cubit.initialize();
      await cubit.signInWithEmail('test@example.com', 'password123');

      expect(cubit.state.isAuthenticated, isTrue);
      expect(cubit.state.user?.email, 'test@example.com');
    });

    test('signInWithEmail should support captcha token', () async {
      await cubit.initialize();
      await cubit.signInWithEmail(
        'test@example.com',
        'password123',
        captchaToken: 'captcha-token-xyz',
      );

      expect(cubit.state.isAuthenticated, isTrue);
    });

    test('signUpWithEmail should create and authenticate user', () async {
      await cubit.initialize();
      await cubit.signUpWithEmail('new@example.com', 'password123');

      expect(cubit.state.isAuthenticated, isTrue);
      expect(cubit.state.user?.email, 'new@example.com');
    });

    test('signUpWithEmail should support captcha token', () async {
      await cubit.initialize();
      await cubit.signUpWithEmail(
        'new@example.com',
        'password123',
        captchaToken: 'captcha-token-xyz',
      );

      expect(cubit.state.isAuthenticated, isTrue);
    });

    test('signOut should clear user and set unauthenticated', () async {
      const user = AuthUser(id: 'user-123', email: 'test@example.com');
      mockRepository.setCurrentUser(user);
      await cubit.initialize();

      expect(cubit.state.isAuthenticated, isTrue);

      await cubit.signOut();
      await Future.delayed(const Duration(milliseconds: 100));

      expect(cubit.state.isAuthenticated, isFalse);
      expect(cubit.state.user, isNull);
    });

    test('should handle sign out errors', () async {
      mockRepository.shouldThrowOnSignOut = true;
      const user = AuthUser(id: 'user-123', email: 'test@example.com');
      mockRepository.setCurrentUser(user);
      await cubit.initialize();

      expect(() => cubit.signOut(), throwsException);
    });

    test('auth state changes should update cubit state', () async {
      await cubit.initialize();
      expect(cubit.state.isAuthenticated, isFalse);

      // Simulate sign in
      const user1 = AuthUser(id: 'user-1', email: 'user1@example.com');
      mockRepository.setCurrentUser(user1);
      await Future.delayed(const Duration(milliseconds: 100));

      expect(cubit.state.isAuthenticated, isTrue);
      expect(cubit.state.user?.id, 'user-1');

      // Simulate sign out
      mockRepository.setCurrentUser(null);
      await Future.delayed(const Duration(milliseconds: 100));

      expect(cubit.state.isAuthenticated, isFalse);
      expect(cubit.state.user, isNull);
    });
  });
}