import 'dart:developer';
import 'dart:io';

import 'package:answer_five/core/network/network_info.dart';
import 'package:answer_five/core/usecases/usecase.dart';
import 'package:answer_five/core/utils/constants/string_constants.dart';
import 'package:answer_five/features/authentication/data/models/player_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/errors/exceptions.dart';

abstract class AuthLocalDatasource {
  Stream<PlayerModel> authStateChanges();
  Future<void> registerUserWithEmailAndPassword(String email, String password);

  Future<void> loginWithEmailAndPassword(String email, String password);

  Future<void> updatePhotoURL(UpdatePhotoUrlParams params);

  Future<void> updateUsername(String username);

  Future<void> logout();
}

class AuthenticationLocalDatasourceImpl implements AuthLocalDatasource {
  final FirebaseAuth _firebaseAuth;
  final NetworkInfo _networkInfo;
  final FirebaseDatabase _firebaseDatabase;
  final FirebaseStorage _firebaseStorage;

  const AuthenticationLocalDatasourceImpl(this._firebaseAuth, this._networkInfo,
      this._firebaseDatabase, this._firebaseStorage);

  @override
  Stream<PlayerModel> authStateChanges() {
    final stream = _firebaseAuth.authStateChanges();
    return stream.asyncMap((user) {
      return PlayerModel.fromUser(user!);
    });
  }

  @override
  Future<void> registerUserWithEmailAndPassword(
      String email, String password) async {
    if (await _networkInfo.isConnected) {
      try {
        await _firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        await _savePlayer();
        return;
      } catch (error) {
        log(error.toString());
        throw const AuthException('Registration failed!');
      }
    }
    log(StringConstants.networkExceptionMessage);
    throw const NetworkException();
  }

  @override
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    if (await _networkInfo.isConnected) {
      try {
        await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
      } catch (error) {
        log(error.toString());
        throw const AuthException('Login failed!');
      }
    } else {
      log(StringConstants.networkExceptionMessage);
      throw const NetworkException();
    }
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
    } else {
      log(StringConstants.networkExceptionMessage);
      throw const NetworkException();
    }
  }

  Future<void> _savePlayer() async {
    final playerModel = PlayerModel.fromUser(_firebaseAuth.currentUser!);
    return await _firebaseDatabase
        .ref()
        .child('/players/${playerModel.id}')
        .set(playerModel.toJson());
  }

  @override
  Future<void> updatePhotoURL(UpdatePhotoUrlParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final file = File(params.path);
        final ref = _firebaseStorage
            .ref()
            .child('images/${_firebaseAuth.currentUser!.uid}/${params.name}');

        await ref.putFile(file);

        final url = await ref.getDownloadURL();

        await _firebaseDatabase
            .ref()
            .child("players/${_firebaseAuth.currentUser!.uid}/")
            .update({'photoUrl': url.toString()});

        return await _firebaseAuth.currentUser!.updatePhotoURL(url);
      } catch (error, stackTrace) {
        log(error: error, stackTrace: stackTrace, error.toString());
        throw const ServerException();
      }
    } else {
      log(StringConstants.networkExceptionMessage);
      throw const NetworkException();
    }
  }

  @override
  Future<void> updateUsername(String username) async {
    if (await _networkInfo.isConnected) {
      try {
        await _firebaseDatabase
            .ref()
            .child("players/${_firebaseAuth.currentUser!.uid}/")
            .update({'username': username});

        return await _firebaseAuth.currentUser!.updateDisplayName(username);
      } catch (error, stackTrace) {
        log(error: error, stackTrace: stackTrace, error.toString());
        throw const ServerException();
      }
    } else {
      log(StringConstants.networkExceptionMessage);
      throw const NetworkException();
    }
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