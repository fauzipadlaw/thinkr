import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../domain/auth_repository.dart';
import 'login_form_state.dart';

@lazySingleton
abstract class LoginFormCubit extends StateStreamableSource<LoginFormState> {
  @factoryMethod
  factory LoginFormCubit(AuthRepository authRepository) = _LoginFormCubitImpl;

  void toggleMode({bool force});
  void updateEmail(String email);
  void updatePassword(String password);
  void updateConfirmPassword(String confirm);
  Future<bool> submit({String? captchaToken});
  Future<void> signInWithGoogle();
  Future<bool> signInAnonymously({String? captchaToken});
  Future<bool> shouldRunCaptcha({
    required bool requiresCaptcha,
    String? errorMessage,
  });
}

class _LoginFormCubitImpl extends Cubit<LoginFormState>
    implements LoginFormCubit {
  final AuthRepository _authRepository;

  _LoginFormCubitImpl(this._authRepository) : super(LoginFormState.initial);

  @override
  void toggleMode({bool force = false}) {
    emit(
      state.copyWith(
        isSignup: !state.isSignup,
        email: force ? '' : state.email,
        password: force ? '' : state.password,
        confirmPassword: '',
        confirmError: null,
        successMessage: null,
        errorMessage: null,
        emailError: force ? null : state.emailError,
        passwordError: force ? null : state.passwordError,
        isDirty: force ? false : state.isDirty,
      ),
    );
  }

  @override
  void updateEmail(String email) {
    emit(
      state.copyWith(
        email: email,
        isDirty: _isDirty(email, state.password, state.confirmPassword),
        emailError: _validateEmail(email),
        errorMessage: null,
        successMessage: null,
      ),
    );
  }

  @override
  void updatePassword(String password) {
    emit(
      state.copyWith(
        password: password,
        isDirty: _isDirty(state.email, password, state.confirmPassword),
        passwordError: _validatePassword(password),
        confirmError: state.isSignup
            ? _validateConfirm(state.confirmPassword, password)
            : null,
        errorMessage: null,
        successMessage: null,
      ),
    );
  }

  @override
  void updateConfirmPassword(String confirm) {
    emit(
      state.copyWith(
        confirmPassword: confirm,
        isDirty: _isDirty(state.email, state.password, confirm),
        confirmError: state.isSignup
            ? _validateConfirm(confirm, state.password)
            : null,
        errorMessage: null,
        successMessage: null,
      ),
    );
  }

  @override
  Future<bool> submit({String? captchaToken}) async {
    final emailError = _validateEmail(state.email);
    final passwordError = _validatePassword(state.password);
    final confirmError = state.isSignup
        ? _validateConfirm(state.confirmPassword, state.password)
        : null;

    if (emailError != null || passwordError != null || confirmError != null) {
      emit(
        state.copyWith(
          emailError: emailError,
          passwordError: passwordError,
          confirmError: confirmError,
          errorMessage: null,
          successMessage: null,
        ),
      );
      return false;
    }

    emit(
      state.copyWith(
        isSubmitting: true,
        errorMessage: null,
        successMessage: null,
      ),
    );

    try {
      if (state.isSignup) {
        await _authRepository.signUpWithEmail(
          email: state.email.trim(),
          password: state.password,
          captchaToken: captchaToken,
        );
        emit(
          state.copyWith(
            isSubmitting: false,
            successMessage: 'login_signupSuccess',
            isDirty: false,
          ),
        );
      } else {
        await _authRepository.signInWithEmail(
          email: state.email.trim(),
          password: state.password,
          captchaToken: captchaToken,
        );
        emit(
          state.copyWith(
            isSubmitting: false,
            successMessage: 'login_signinSuccess',
            isDirty: false,
          ),
        );
      }
      return true;
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, errorMessage: e.toString()));
      return false;
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    emit(state.copyWith(isSubmitting: true, errorMessage: null));
    try {
      await _authRepository.signInWithGoogle();
      emit(state.copyWith(isSubmitting: false));
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, errorMessage: e.toString()));
    }
  }

  @override
  Future<bool> signInAnonymously({String? captchaToken}) async {
    emit(state.copyWith(isSubmitting: true, errorMessage: null));
    try {
      await _authRepository.signInAnonymously(captchaToken: captchaToken);
      emit(
        state.copyWith(
          isSubmitting: false,
          successMessage: 'login_guestSuccess',
          isDirty: false,
        ),
      );
      return true;
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, errorMessage: e.toString()));
      return false;
    }
  }

  @override
  Future<bool> shouldRunCaptcha({
    required bool requiresCaptcha,
    String? errorMessage,
  }) async {
    if (!requiresCaptcha || !_isCaptchaError(errorMessage)) return false;
    final user = await _authRepository.currentUser;
    return user == null;
  }

  bool _isCaptchaError(String? message) {
    if (message == null) return false;
    final lower = message.toLowerCase();
    return lower.contains('captcha required') ||
        lower.contains('captcha verification') ||
        lower.contains('captcha_token');
  }

  bool _isDirty(String email, String password, String confirm) =>
      email.trim().isNotEmpty || password.isNotEmpty || confirm.isNotEmpty;

  String? _validateEmail(String email) {
    final trimmed = email.trim();
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (trimmed.isEmpty) return 'login_emailRequired';
    if (!regex.hasMatch(trimmed)) return 'login_emailInvalid';
    return null;
  }

  String? _validatePassword(String password) {
    if (password.isEmpty) return 'login_passwordRequired';
    if (password.length < 6) return 'login_passwordTooShort';
    return null;
  }

  String? _validateConfirm(String confirm, String password) {
    if (confirm != password) return 'login_passwordMismatch';
    return null;
  }
}
