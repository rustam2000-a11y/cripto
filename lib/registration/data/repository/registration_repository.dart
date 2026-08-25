import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../core/models/user_model.dart';
import '../api/registration_api.dart';

@LazySingleton(as: RegistrationRepositoryI)
class RegistrationRepository extends RegistrationRepositoryI {
  RegistrationRepository({required RegistrationApiI api}) : _api = api;

  final RegistrationApiI _api;

  @override
  Stream<User?> authStateChanges() => _api.authStateChanges();

  @override
  User? get currentUser => _api.currentUser;

  @override
  Future<UserModel?> signInWithEmail({
    required String email,
    required String password,
  }) {
    return _api.signInWithEmail(email: email, password: password);
  }

  @override
  Future<UserModel?> registerWithEmail({
    required String email,
    required String password,
    required String name,
  }) {
    return _api.registerWithEmail(
      email: email,
      password: password,
      name: name,
    );
  }

  @override
  Future<UserModel?> signInWithGoogle() => _api.signInWithGoogle();

  @override
  Future<UserModel?> signInWithApple() => _api.signInWithApple();

  @override
  Future<void> sendPasswordResetEmail(String email) {
    return _api.sendPasswordResetEmail(email);
  }

  @override
  Future<void> signOut() => _api.signOut();

  @override
  Future<void> addCoinToFavorites(String coinId) => _api.addCoinToFavorites(coinId);
}

abstract class RegistrationRepositoryI {
  Stream<User?> authStateChanges();

  User? get currentUser;

  Future<UserModel?> signInWithEmail({
    required String email,
    required String password,
  });

  Future<UserModel?> registerWithEmail({
    required String email,
    required String password,
    required String name,
  });

  Future<UserModel?> signInWithGoogle();

  Future<UserModel?> signInWithApple();

  Future<void> sendPasswordResetEmail(String email);

  Future<void> signOut();

  Future<void> addCoinToFavorites(String coinId);
}
