import 'dart:async';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthUser;

import '../../../core/env/environment.dart';
import '../domain/auth_repository.dart';
import '../domain/auth_user.dart';

@LazySingleton(as: AuthRepository)
class SupabaseAuthRepository implements AuthRepository {
  final SupabaseClient _client;
  final EnvConfig _envConfig;
  final GoogleSignIn _googleSignIn;
  final _controller = StreamController<AuthUser?>.broadcast();
  bool _googleSignInInitialized = false;

  SupabaseAuthRepository(this._client, this._envConfig)
    : _googleSignIn = GoogleSignIn.instance {
    final user = _client.auth.currentUser;
    _controller.add(_mapUser(user));

    _client.auth.onAuthStateChange.listen((data) {
      final session = data.session;
      final user = session?.user;
      _controller.add(_mapUser(user));
    });
  }

  AuthUser? _mapUser(User? user) {
    if (user == null) return null;
    return AuthUser(id: user.id, email: user.email);
  }

  @override
  Stream<AuthUser?> get authStateChanges => _controller.stream;

  @override
  Future<AuthUser?> get currentUser async {
    return _mapUser(_client.auth.currentUser);
  }

  void _validateEmailPassword(String email, String password) {
    final emailPattern = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (email.isEmpty || !emailPattern.hasMatch(email)) {
      throw ArgumentError('Please enter a valid email address.');
    }
    if (password.isEmpty || password.length < 6) {
      throw ArgumentError('Password must be at least 6 characters.');
    }
  }

  Future<void> _initializeGoogleSignIn() async {
    if (_googleSignInInitialized || kIsWeb) return;

    await _googleSignIn.initialize(
      serverClientId: _envConfig.googleWebClientId.isNotEmpty
          ? _envConfig.googleWebClientId
          : null,
      clientId: _envConfig.googleIosClientId.isNotEmpty
          ? _envConfig.googleIosClientId
          : null,
    );
    _googleSignInInitialized = true;
  }

  @override
  Future<void> signInWithGoogle() async {
    if (kIsWeb) {
      // Web: use redirectTo from env (per environment)
      final redirectTo = _envConfig.supabaseRedirectUrl.isNotEmpty
          ? _envConfig.supabaseRedirectUrl
          : null;
      await _client.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: redirectTo,
      );
      return;
    }

    await _initializeGoogleSignIn();

    try {
      // Use `authenticate()` for interactive sign-in. `attemptLightweightAuthentication`
      // is for silent sign-in and will fail for new users.
      final googleUser = await _googleSignIn.authenticate();

      final auth = googleUser.authentication;
      final idToken = auth.idToken;

      if (idToken == null) {
        throw AuthException('No ID token returned from Google.');
      }

      await _client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
      );
    } on GoogleSignInException catch (e) {
      // The user canceled the sign-in flow.
      if (e.code == GoogleSignInExceptionCode.canceled) {
        return; // Not an error, just return.
      }
      throw AuthException(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  @override
  Future<void> signInAnonymously({String? captchaToken}) async {
    await _client.auth.signInAnonymously(captchaToken: captchaToken);
  }

  @override
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    String? captchaToken,
  }) async {
    _validateEmailPassword(email, password);
    await _client.auth.signUp(
      email: email,
      password: password,
      captchaToken: captchaToken,
    );
  }

  @override
  Future<void> signInWithEmail({
    required String email,
    required String password,
    String? captchaToken,
  }) async {
    _validateEmailPassword(email, password);
    await _client.auth.signInWithPassword(
      email: email,
      password: password,
      captchaToken: captchaToken,
    );
  }
}
