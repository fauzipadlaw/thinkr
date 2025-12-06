import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:thinkr/features/auth/domain/auth_repository.dart';
import 'package:thinkr/features/auth/domain/auth_user.dart';

import 'auth_state.dart';

@lazySingleton
abstract class AuthCubit extends StateStreamableSource<AuthState> {
  @factoryMethod
  factory AuthCubit(AuthRepository authRepository) = _AuthCubitImpl;

  Future<void> initialize();
  Future<void> signIn();
  Future<void> signInWithEmail(
    String email,
    String password, {
    String? captchaToken,
  });
  Future<void> signUpWithEmail(
    String email,
    String password, {
    String? captchaToken,
  });
  Future<void> signOut();
}

class _AuthCubitImpl extends Cubit<AuthState> implements AuthCubit {
  final AuthRepository _authRepository;

  _AuthCubitImpl(this._authRepository) : super(AuthState.initial);

  @override
  Future<void> initialize() async {
    final user = await _authRepository.currentUser;
    if (user == null) {
      emit(
        state.copyWith(user: null, isAuthenticated: false, isUnknown: false),
      );
    } else {
      emit(state.copyWith(user: user, isAuthenticated: true, isUnknown: false));
    }

    _authRepository.authStateChanges.listen((AuthUser? user) {
      if (user == null) {
        emit(
          state.copyWith(user: null, isAuthenticated: false, isUnknown: false),
        );
      } else {
        emit(
          state.copyWith(user: user, isAuthenticated: true, isUnknown: false),
        );
      }
    });
  }

  @override
  Future<void> signIn() async {
    await _authRepository.signInWithGoogle();
  }

  @override
  Future<void> signInWithEmail(
    String email,
    String password, {
    String? captchaToken,
  }) {
    return _authRepository.signInWithEmail(
      email: email,
      password: password,
      captchaToken: captchaToken,
    );
  }

  @override
  Future<void> signUpWithEmail(
    String email,
    String password, {
    String? captchaToken,
  }) {
    return _authRepository.signUpWithEmail(
      email: email,
      password: password,
      captchaToken: captchaToken,
    );
  }

  @override
  Future<void> signOut() async {
    await _authRepository.signOut();
  }
}
