import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:thinkr/features/auth/domain/auth_repository.dart';
import 'package:thinkr/features/auth/domain/auth_user.dart';

@LazySingleton(as: AuthRepository)
class DummyAuthRepository implements AuthRepository {
  AuthUser? _user;
  final _controller = StreamController<AuthUser?>.broadcast();

  DummyAuthRepository();

  @override
  Stream<AuthUser?> get authStateChanges => _controller.stream;

  @override
  Future<AuthUser?> get currentUser async => _user;

  @override
  Future<void> signInWithGoogle() async {
    _user = const AuthUser(id: 'dummy-id', email: 'dummy@thinkr.app');
    _controller.add(_user);
  }

  @override
  Future<void> signOut() async {
    _user = null;
    _controller.add(_user);
  }
}
