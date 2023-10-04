import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:refactored_muda_facil/repositories/auth_repository.dart';

class AuthController extends StateNotifier<User?> {
  final Ref _ref;

  StreamSubscription<User?>? _authStateChangesSubscription;

  AuthController(this._ref) : super(null) {
    _authStateChangesSubscription?.cancel();
    _authStateChangesSubscription =
        _ref.read(authRepositoryProvider).authStateChanges.listen((user) {
      state = user;
    });
  }

  @override
  void dispose() {
    _authStateChangesSubscription?.cancel();
    super.dispose();
  }

  void signOut() async {
    _ref.read(authRepositoryProvider).signOut();
  }
}

final AuthControllerProvider =
    StateNotifierProvider<AuthController, User?>((ref) => AuthController(ref));
