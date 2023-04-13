import 'dart:developer';

import 'package:answer_five/core/network/network_info.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/constants/string_constants.dart';
import '../../domain/entities/statistic.dart';
import '../models/player_model.dart';
import '../models/statistic_model.dart';

abstract class StatsRemoteDataSource {
  Future<PlayerModel> getStats(PlayerModel playerModel);
  Future<void> updateStats(PlayerModel playerModel);
}

class StatsRemoteDataSourceImpl implements StatsRemoteDataSource {
  final FirebaseDatabase _firebaseDatabase;
  final NetworkInfo _networkInfo;

  const StatsRemoteDataSourceImpl(this._firebaseDatabase, this._networkInfo);
  @override
  Future<PlayerModel> getStats(PlayerModel playerModel) async {
    if (await _networkInfo.isConnected) {
      try {
        final playerSnapshot = await _firebaseDatabase
            .ref()
            .child('/players/${playerModel.id}')
            .once();
        final player = PlayerModel.fromMap(Map<String, dynamic>.from(
            playerSnapshot.snapshot.value as Map<dynamic, dynamic>));

        return player;
      } catch (error) {
        log(error.toString());
        throw const ServerException();
      }
    }
    log(StringConstants.networkExceptionMessage);
    throw const NetworkException();
  }

  @override
  Future<void> updateStats(PlayerModel playerModel) async {
    if (await _networkInfo.isConnected) {
      try {
        final map = playerModel.toJson();
        await _firebaseDatabase
            .ref()
            .child('/players/${playerModel.id}')
            .update(map);
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
