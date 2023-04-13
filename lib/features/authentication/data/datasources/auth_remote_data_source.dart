import 'dart:developer';

import 'package:answer_five/core/network/network_info.dart';
import 'package:answer_five/core/utils/constants/string_constants.dart';
import 'package:answer_five/features/authentication/data/models/player_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/statistic_model.dart';

abstract class AuthLocalDatasource {
  Stream<PlayerModel?> authStateChanges();
  Future<PlayerModel> registerUserWithEmailAndPassword(
      String email, String password);

  Future<PlayerModel> loginWithEmailAndPassword(String email, String password);

  Future<void> logout();
}

class AuthenticationLocalDatasourceImpl implements AuthLocalDatasource {
  final FirebaseAuth _firebaseAuth;
  final NetworkInfo _networkInfo;
  final FirebaseDatabase _firebaseDatabase;

  const AuthenticationLocalDatasourceImpl(
      this._firebaseAuth, this._networkInfo, this._firebaseDatabase);

  @override
  Stream<PlayerModel?> authStateChanges() {
    try {
      final userStream = _firebaseAuth.authStateChanges();
      final userModelStream = userStream.asyncMap((user) async {
        if (user == null) {
          return null;
        } else {
          final playerSnapshot = await _firebaseDatabase
              .ref()
              .child('/players/${user.uid}')
              .once();
          final player = PlayerModel.fromMap(Map<String, dynamic>.from(
              playerSnapshot.snapshot.value as Map<dynamic, dynamic>));

          return player;
        }
      });

      return userModelStream;
    } catch (error) {
      log(error.toString());

      throw const AuthException('User does not exist!');
    }
  }

  @override
  Future<PlayerModel> registerUserWithEmailAndPassword(
      String email, String password) async {
    if (await _networkInfo.isConnected) {
      try {
        final databaseRef = _firebaseDatabase.ref();

        final userCredentials = await _firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);
        final firebaseUser = userCredentials.user;
        //Check for null value
        final playerModel = PlayerModel.fromUser(firebaseUser!);
        final playerRef = databaseRef.child('/players/${firebaseUser.uid}');
        await playerRef.set(playerModel.toJson());
        return playerModel;
      } catch (error) {
        log(error.toString());
        throw const AuthException('Registration failed!');
      }
    }
    log(StringConstants.networkExceptionMessage);
    throw const NetworkException();
  }

  @override
  Future<PlayerModel> loginWithEmailAndPassword(
      String email, String password) async {
    if (await _networkInfo.isConnected) {
      try {
        final userCredentials = await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        final firebaseUser = userCredentials.user;
        final playerSnapshot = await _firebaseDatabase
            .ref()
            .child('/players/${firebaseUser!.uid}')
            .once();
        final player = PlayerModel.fromMap(Map<String, dynamic>.from(
            playerSnapshot.snapshot.value as Map<dynamic, dynamic>));

        return player;
      } catch (error) {
        log(error.toString());
        log("hea");
        throw const AuthException('Login failed!');
      }
    }
    log(StringConstants.networkExceptionMessage);
    throw const NetworkException();
  }

  @override
  Future<void> logout() async {
    if (await _networkInfo.isConnected) {
      try {
        return await _firebaseAuth.signOut();
      } catch (error) {
        log(error.toString());
        throw const AuthException('Logout failed!');
      }
    }
    log(StringConstants.networkExceptionMessage);
    throw const NetworkException();
  }
}

  //   @override
  // Stream<PlayerModel?> authStateChanges() {
  //   try {
  //     final userStream = _firebaseAuth.authStateChanges();
  //     //Check for null value
  //     final userModelStream = userStream.map((user) {
  //       final playerSnapshot =
  //           _firebaseDatabase.ref().child('/players/${user!.uid}').once();
  //       final player = PlayerModel.fromMap(Map<String, dynamic>.from(
  //           playerSnapshot.then(
  //                   (value) => value.snapshot.value as Map<dynamic, dynamic>)
  //               as Map<dynamic, dynamic>));
  //       return player;
  //     });
  //     return userModelStream;
  //   } catch (error) {
  //     log(error.toString());
  //     throw const AuthException('User does not exist!');
  //   }
  // }