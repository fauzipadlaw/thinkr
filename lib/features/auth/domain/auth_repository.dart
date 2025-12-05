import 'dart:async';

import 'auth_user.dart';

abstract class AuthRepository {
  Stream<AuthUser?> get authStateChanges;
  Future<AuthUser?> get currentUser;

  Future<void> signInWithGoogle(); // dummy for now
  Future<void> signOut();
}
