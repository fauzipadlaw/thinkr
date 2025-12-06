import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_form_state.freezed.dart';

@freezed
abstract class LoginFormState with _$LoginFormState {
  const factory LoginFormState({
    @Default('') String email,
    @Default('') String password,
    @Default('') String confirmPassword,
    @Default(false) bool isSignup,
    @Default(false) bool isSubmitting,
    @Default(false) bool isDirty,
    String? errorMessage,
    String? successMessage,
    String? emailError,
    String? passwordError,
    String? confirmError,
  }) = _LoginFormState;

  const LoginFormState._();

  static const initial = LoginFormState();
}
