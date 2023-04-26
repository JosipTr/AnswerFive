import 'dart:developer';

import 'package:answer_five/core/errors/exceptions.dart';
import 'package:answer_five/core/network/network_info.dart';
import 'package:answer_five/core/utils/constants/string_constants.dart';
import 'package:answer_five/features/statistic/data/models/statistic_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../authentication/data/models/player_model.dart';

abstract class HomeRemoteDatasource {
  Stream<PlayerModel> getPlayer();

  Future<void> updatePlayerStats(StatisticModel statisticModel);

  Stream<void> updateLastActive(String date);

  Future<void> updateTodayQuestionNumber();
}

class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseDatabase _firebaseDatabase;
  final NetworkInfo _networkInfo;
  final FirebaseStorage _firebaseStorage;

  const HomeRemoteDatasourceImpl(this._firebaseAuth, this._firebaseDatabase,
      this._networkInfo, this._firebaseStorage);

  @override
  Stream<PlayerModel> getPlayer() {
    return _firebaseDatabase
        .ref()
        .child("players/${_firebaseAuth.currentUser!.uid}")
        .onValue
        .map((event) => PlayerModel.fromJson(
            event.snapshot.value as Map<dynamic, dynamic>));
  }

  @override
  Future<void> updatePlayerStats(StatisticModel statisticModel) async {
    if (await _networkInfo.isConnected) {
      try {
        return await _firebaseDatabase
            .ref()
            .child("players/${_firebaseAuth.currentUser!.uid}/statistic")
            .update(statisticModel.toJson());
      } catch (error) {
        log(error.toString());
        throw const ServerException();
      }
    } else {
      log(StringConstants.networkExceptionMessage);
      throw const NetworkException();
    }
  }

  @override
  Stream<void> updateLastActive(String date) async* {
    if (await _networkInfo.isConnected) {
      try {
        yield* _firebaseDatabase
            .ref()
            .child("players/${_firebaseAuth.currentUser!.uid}")
            .onValue
            .asyncExpand((event) async* {
          await updateTodayQuestionNumber();
          await _firebaseDatabase
              .ref()
              .child("players/${_firebaseAuth.currentUser!.uid}")
              .update({'lastActive': date});
        });
      } catch (error) {
        log(error.toString());
        throw const ServerException();
      }
    } else {
      log(StringConstants.networkExceptionMessage);
      throw const NetworkException();
    }
  }

  @override
  Future<void> updateTodayQuestionNumber() async {
    if (await _networkInfo.isConnected) {
      try {
        final date = DateTime.now();
        final event = await _firebaseDatabase
            .ref()
            .child("players/${_firebaseAuth.currentUser!.uid}/lastActive")
            .once();
        final lastActive = event.snapshot.value as String;
        final lastActiveDate = DateTime.parse(lastActive);
        if (lastActiveDate.day < date.day &&
            lastActiveDate.month <= date.month &&
            lastActiveDate.year <= date.year) {
          return await _firebaseDatabase
              .ref()
              .child("players/${_firebaseAuth.currentUser!.uid}/statistic/")
              .update({'todayQuestionNumber': 0});
        }
      } catch (error) {
        log(error.toString());
        throw const ServerException();
      }
    } else {
      log(StringConstants.networkExceptionMessage);
      throw const NetworkException();
    }
  }
}
