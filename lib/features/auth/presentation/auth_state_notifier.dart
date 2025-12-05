import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../domain/auth_repository.dart';
import '../domain/auth_user.dart';

@lazySingleton
class AuthStateNotifier extends ChangeNotifier {
  final AuthRepository _authRepository;

  AuthUser? _user;
  late final StreamSubscription<AuthUser?> _sub;

  AuthStateNotifier(this._authRepository) {
    _sub = _authRepository.authStateChanges.listen((user) {
      _user = user;
      notifyListeners();
    });

    // Initial user
    _authRepository.currentUser.then((user) {
      _user = user;
      notifyListeners();
    });
  }

  bool get isLoggedIn => _user != null;

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}
