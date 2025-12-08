import 'package:flutter_test/flutter_test.dart';
import 'package:thinkr/features/auth/domain/auth_user.dart';
import 'package:thinkr/features/auth/presentation/login_form_cubit.dart';
import 'package:thinkr/features/auth/presentation/login_form_state.dart';
import '../../../helpers/mock_auth_repository.dart';

void main() {
  late MockAuthRepository mockRepository;
  late LoginFormCubit cubit;

  setUp(() {
    mockRepository = MockAuthRepository();
    cubit = LoginFormCubit(mockRepository);
  });

  tearDown(() {
    cubit.close();
    mockRepository.dispose();
  });

  group('LoginFormCubit', () {
    test('initial state should have default values', () {
      expect(cubit.state, equals(LoginFormState.initial));
      expect(cubit.state.email, '');
      expect(cubit.state.password, '');
      expect(cubit.state.isSignup, isFalse);
      expect(cubit.state.isSubmitting, isFalse);
      expect(cubit.state.isDirty, isFalse);
    });

    group('toggleMode', () {
      test('should switch between sign in and sign up', () {
        expect(cubit.state.isSignup, isFalse);

        cubit.toggleMode();
        expect(cubit.state.isSignup, isTrue);

        cubit.toggleMode();
        expect(cubit.state.isSignup, isFalse);
      });

      test('should preserve email and password when toggling', () {
        cubit.updateEmail('test@example.com');
        cubit.updatePassword('password123');

        cubit.toggleMode();

        expect(cubit.state.email, 'test@example.com');
        expect(cubit.state.password, 'password123');
      });

      test('should clear fields when force is true', () {
        cubit.updateEmail('test@example.com');
        cubit.updatePassword('password123');

        cubit.toggleMode(force: true);

        expect(cubit.state.email, '');
        expect(cubit.state.password, '');
        expect(cubit.state.isDirty, isFalse);
      });

      test('should clear confirm password when toggling', () {
        cubit.updateConfirmPassword('password123');
        cubit.toggleMode();

        expect(cubit.state.confirmPassword, '');
      });
    });

    group('updateEmail', () {
      test('should update email and set dirty flag', () {
        cubit.updateEmail('test@example.com');

        expect(cubit.state.email, 'test@example.com');
        expect(cubit.state.isDirty, isTrue);
      });

      test('should validate email format', () {
        cubit.updateEmail('invalid-email');

        expect(cubit.state.emailError, isNotNull);
        expect(cubit.state.emailError, 'login_emailInvalid');
      });

      test('should require email', () {
        cubit.updateEmail('');

        expect(cubit.state.emailError, 'login_emailRequired');
      });

      test('should accept valid email', () {
        cubit.updateEmail('valid@example.com');

        expect(cubit.state.emailError, isNull);
      });

      test('should clear error messages', () {
        cubit.updateEmail('test@example.com');

        expect(cubit.state.errorMessage, isNull);
        expect(cubit.state.successMessage, isNull);
      });
    });

    group('updatePassword', () {
      test('should update password and set dirty flag', () {
        cubit.updatePassword('password123');

        expect(cubit.state.password, 'password123');
        expect(cubit.state.isDirty, isTrue);
      });

      test('should require password', () {
        cubit.updatePassword('');

        expect(cubit.state.passwordError, 'login_passwordRequired');
      });

      test('should validate password length', () {
        cubit.updatePassword('12345');

        expect(cubit.state.passwordError, 'login_passwordTooShort');
      });

      test('should accept valid password', () {
        cubit.updatePassword('password123');

        expect(cubit.state.passwordError, isNull);
      });

      test('should validate confirm password in signup mode', () {
        cubit.toggleMode(); // Switch to signup
        cubit.updatePassword('password123');
        cubit.updateConfirmPassword('different');

        cubit.updatePassword('newpassword');

        expect(cubit.state.confirmError, 'login_passwordMismatch');
      });
    });

    group('updateConfirmPassword', () {
      test('should update confirm password', () {
        cubit.updateConfirmPassword('password123');

        expect(cubit.state.confirmPassword, 'password123');
        expect(cubit.state.isDirty, isTrue);
      });

      test('should validate password match in signup mode', () {
        cubit.toggleMode(); // Switch to signup
        cubit.updatePassword('password123');
        cubit.updateConfirmPassword('different');

        expect(cubit.state.confirmError, 'login_passwordMismatch');
      });

      test('should clear error when passwords match', () {
        cubit.toggleMode(); // Switch to signup
        cubit.updatePassword('password123');
        cubit.updateConfirmPassword('password123');

        expect(cubit.state.confirmError, isNull);
      });
    });

    group('submit - sign in', () {
      test('should successfully sign in with valid credentials', () async {
        cubit.updateEmail('test@example.com');
        cubit.updatePassword('password123');

        final result = await cubit.submit();

        expect(result, isTrue);
        expect(cubit.state.isSubmitting, isFalse);
        expect(cubit.state.successMessage, 'login_signinSuccess');
        expect(cubit.state.isDirty, isFalse);
      });

      test('should fail with invalid email', () async {
        cubit.updateEmail('invalid');
        cubit.updatePassword('password123');

        final result = await cubit.submit();

        expect(result, isFalse);
        expect(cubit.state.emailError, isNotNull);
      });

      test('should fail with short password', () async {
        cubit.updateEmail('test@example.com');
        cubit.updatePassword('123');

        final result = await cubit.submit();

        expect(result, isFalse);
        expect(cubit.state.passwordError, isNotNull);
      });

      test('should handle authentication errors', () async {
        mockRepository.shouldThrowOnSignIn = true;
        mockRepository.errorMessage = 'Invalid credentials';

        cubit.updateEmail('test@example.com');
        cubit.updatePassword('password123');

        final result = await cubit.submit();

        expect(result, isFalse);
        expect(cubit.state.errorMessage, contains('Invalid credentials'));
        expect(cubit.state.isSubmitting, isFalse);
      });

      test('should support captcha token', () async {
        cubit.updateEmail('test@example.com');
        cubit.updatePassword('password123');

        final result = await cubit.submit(captchaToken: 'captcha-xyz');

        expect(result, isTrue);
      });
    });

    group('submit - sign up', () {
      test('should successfully sign up with valid data', () async {
        cubit.toggleMode(); // Switch to signup
        cubit.updateEmail('new@example.com');
        cubit.updatePassword('password123');
        cubit.updateConfirmPassword('password123');

        final result = await cubit.submit();

        expect(result, isTrue);
        expect(cubit.state.successMessage, 'login_signupSuccess');
      });

      test('should fail when passwords do not match', () async {
        cubit.toggleMode(); // Switch to signup
        cubit.updateEmail('new@example.com');
        cubit.updatePassword('password123');
        cubit.updateConfirmPassword('different');

        final result = await cubit.submit();

        expect(result, isFalse);
        expect(cubit.state.confirmError, isNotNull);
      });

      test('should handle signup errors', () async {
        mockRepository.shouldThrowOnSignUp = true;
        mockRepository.errorMessage = 'Email already exists';

        cubit.toggleMode(); // Switch to signup
        cubit.updateEmail('existing@example.com');
        cubit.updatePassword('password123');
        cubit.updateConfirmPassword('password123');

        final result = await cubit.submit();

        expect(result, isFalse);
        expect(cubit.state.errorMessage, contains('Email already exists'));
      });
    });

    group('signInWithGoogle', () {
      test('should successfully sign in with Google', () async {
        await cubit.signInWithGoogle();

        expect(cubit.state.isSubmitting, isFalse);
        expect(cubit.state.errorMessage, isNull);
      });

      test('should handle Google sign-in errors', () async {
        mockRepository.shouldThrowOnSignIn = true;
        mockRepository.errorMessage = 'Google sign-in cancelled';

        await cubit.signInWithGoogle();

        expect(cubit.state.errorMessage, contains('Google sign-in cancelled'));
        expect(cubit.state.isSubmitting, isFalse);
      });
    });

    group('signInAnonymously', () {
      test('should successfully sign in anonymously', () async {
        final result = await cubit.signInAnonymously();

        expect(result, isTrue);
        expect(cubit.state.successMessage, 'login_guestSuccess');
        expect(cubit.state.isDirty, isFalse);
      });

      test('should handle anonymous sign-in errors', () async {
        mockRepository.shouldThrowOnSignIn = true;
        mockRepository.errorMessage = 'Anonymous sign-in disabled';

        final result = await cubit.signInAnonymously();

        expect(result, isFalse);
        expect(
          cubit.state.errorMessage,
          contains('Anonymous sign-in disabled'),
        );
      });

      test('should support captcha token', () async {
        final result = await cubit.signInAnonymously(
          captchaToken: 'captcha-xyz',
        );

        expect(result, isTrue);
      });
    });

    group('shouldRunCaptcha', () {
      test('should return false when captcha not required', () async {
        final result = await cubit.shouldRunCaptcha(requiresCaptcha: false);

        expect(result, isFalse);
      });

      test('should return false when error is not captcha-related', () async {
        final result = await cubit.shouldRunCaptcha(
          requiresCaptcha: true,
          errorMessage: 'Invalid password',
        );

        expect(result, isFalse);
      });

      test(
        'should return true for captcha error when not authenticated',
        () async {
          final result = await cubit.shouldRunCaptcha(
            requiresCaptcha: true,
            errorMessage: 'captcha required',
          );

          expect(result, isTrue);
        },
      );

      test(
        'should return false for captcha error when authenticated',
        () async {
          mockRepository.setCurrentUser(
            const AuthUser(id: 'user-123', email: 'test@example.com'),
          );

          final result = await cubit.shouldRunCaptcha(
            requiresCaptcha: true,
            errorMessage: 'captcha required',
          );

          expect(result, isFalse);
        },
      );

      test('should detect various captcha error messages', () async {
        final messages = [
          'Captcha Required',
          'captcha verification failed',
          'Please provide captcha_token',
        ];

        for (final message in messages) {
          final result = await cubit.shouldRunCaptcha(
            requiresCaptcha: true,
            errorMessage: message,
          );

          expect(result, isTrue, reason: 'Failed for message: $message');
        }
      });
    });

    group('edge cases', () {
      test('should trim email whitespace', () async {
        cubit.updateEmail('  test@example.com  ');
        cubit.updatePassword('password123');

        final result = await cubit.submit();

        expect(result, isTrue);
      });

      test('should handle empty strings', () {
        cubit.updateEmail('');
        cubit.updatePassword('');

        expect(cubit.state.emailError, 'login_emailRequired');
        expect(cubit.state.passwordError, 'login_passwordRequired');
      });

      test('should not be dirty with only whitespace', () {
        cubit.updateEmail('   ');

        expect(cubit.state.isDirty, isFalse);
      });
    });
  });
}
