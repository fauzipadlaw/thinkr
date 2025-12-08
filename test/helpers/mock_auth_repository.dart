import 'dart:async';
import 'package:thinkr/features/auth/domain/auth_repository.dart';
import 'package:thinkr/features/auth/domain/auth_user.dart';

class MockAuthRepository implements AuthRepository {
  final StreamController<AuthUser?> _authStateController =
      StreamController<AuthUser?>.broadcast();
  AuthUser? _currentUser;
  bool shouldThrowOnSignIn = false;
  bool shouldThrowOnSignUp = false;
  bool shouldThrowOnSignOut = false;
  String? errorMessage;

  @override
  Stream<AuthUser?> get authStateChanges => _authStateController.stream;

  @override
  Future<AuthUser?> get currentUser async => _currentUser;

  void setCurrentUser(AuthUser? user) {
    _currentUser = user;
    _authStateController.add(user);
  }

  @override
  Future<void> signInWithGoogle() async {
    if (shouldThrowOnSignIn) {
      throw Exception(errorMessage ?? 'Google sign-in failed');
    }
    final user = const AuthUser(
      id: 'google-user-123',
      email: 'test@google.com',
    );
    setCurrentUser(user);
  }

  @override
  Future<void> signInAnonymously({String? captchaToken}) async {
    if (shouldThrowOnSignIn) {
      throw Exception(errorMessage ?? 'Anonymous sign-in failed');
    }
    final user = const AuthUser(id: 'anon-user-123');
    setCurrentUser(user);
  }

  @override
  Future<void> signInWithEmail({
    required String email,
    required String password,
    String? captchaToken,
  }) async {
    if (shouldThrowOnSignIn) {
      throw Exception(errorMessage ?? 'Email sign-in failed');
    }
    final user = AuthUser(id: 'email-user-123', email: email);
    setCurrentUser(user);
  }

  @override
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    String? captchaToken,
  }) async {
    if (shouldThrowOnSignUp) {
      throw Exception(errorMessage ?? 'Email sign-up failed');
    }
    final user = AuthUser(id: 'new-user-123', email: email);
    setCurrentUser(user);
  }

  @override
  Future<void> signOut() async {
    if (shouldThrowOnSignOut) {
      throw Exception(errorMessage ?? 'Sign-out failed');
    }
    setCurrentUser(null);
  }

  void dispose() {
    _authStateController.close();
  }
}
