import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:thinkr/features/auth/domain/auth_user.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    AuthUser? user,
    @Default(true) bool isUnknown,
    @Default(false) bool isAuthenticated,
  }) = _AuthState;

  static const AuthState initial = AuthState();
}
