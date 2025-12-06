import 'dart:async';

import 'auth_user.dart';

abstract class AuthRepository {
  Stream<AuthUser?> get authStateChanges;
  Future<AuthUser?> get currentUser;

  Future<void> signInWithGoogle(); // dummy for now
  Future<void> signInWithEmail({
    required String email,
    required String password,
  });
  Future<void> signUpWithEmail({
    required String email,
    required String password,
  });
  Future<void> signOut();
}
