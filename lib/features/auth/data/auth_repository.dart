import 'dart:async';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthUser;

import '../../../core/env/environment.dart';
import '../domain/auth_repository.dart';
import '../domain/auth_user.dart';

@LazySingleton(as: AuthRepository)
class SupabaseAuthRepository implements AuthRepository {
  final SupabaseClient _client;
  final EnvConfig _envConfig;
  final _controller = StreamController<AuthUser?>.broadcast();

  SupabaseAuthRepository(this._client, this._envConfig) {
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
        // You can add scopes/options here if needed per env
      );
    } else {
      // Mobile / desktop: default OAuth flow, using deep links
      await _client.auth.signInWithOAuth(OAuthProvider.google);
    }
  }

  @override
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  @override
  Future<void> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    _validateEmailPassword(email, password);
    await _client.auth.signUp(email: email, password: password);
  }

  @override
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    _validateEmailPassword(email, password);
    await _client.auth.signInWithPassword(email: email, password: password);
  }
}
