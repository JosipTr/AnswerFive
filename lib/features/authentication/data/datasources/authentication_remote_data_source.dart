import 'dart:developer';

import 'package:answer_five/features/authentication/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/errors/exceptions.dart';

abstract class AuthenticationLocalDatasource {
  Stream<UserModel?> authStateChanges();
  Future<UserModel> registerUserWithEmailAndPassword(
      String email, String password);

  Future<UserModel> loginWithEmailAndPassword(String email, String password);
}

class AuthenticationLocalDatasourceImpl
    implements AuthenticationLocalDatasource {
  final FirebaseAuth _firebaseAuth;

  const AuthenticationLocalDatasourceImpl(this._firebaseAuth);

  @override
  Stream<UserModel?> authStateChanges() {
    try {
      final userStream = _firebaseAuth.authStateChanges();
      //Check for null value
      final userModelStream =
          userStream.map((user) => UserModel.fromUser(user!));
      return userModelStream;
    } catch (error) {
      log(error.toString());
      throw const AuthenticationException();
    }
  }

  @override
  Future<UserModel> registerUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredentials = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      final firebaseUser = userCredentials.user;
      //Check for null value
      final userModel = UserModel.fromUser(firebaseUser!);
      return userModel;
    } catch (error) {
      log(error.toString());
      throw const AuthenticationException();
    }
  }

  @override
  Future<UserModel> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredentials = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final firebaseUser = userCredentials.user;
      //Check for null value
      final userModel = UserModel.fromUser(firebaseUser!);
      return userModel;
    } catch (error) {
      log(error.toString());
      throw const AuthenticationException();
    }
  }
}
