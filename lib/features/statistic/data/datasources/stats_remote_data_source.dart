import 'dart:developer';

import 'package:answer_five/core/network/network_info.dart';
import 'package:answer_five/features/statistic/data/models/statistic_model.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/constants/string_constants.dart';
import '../../../authentication/data/models/player_model.dart';

abstract class StatsRemoteDataSource {
  Future<List<PlayerModel>> getStats();
  Future<void> updateStats(String id, StatisticModel statisticModel);
}

class StatsRemoteDataSourceImpl implements StatsRemoteDataSource {
  final FirebaseDatabase _firebaseDatabase;
  final NetworkInfo _networkInfo;

  const StatsRemoteDataSourceImpl(this._firebaseDatabase, this._networkInfo);
  @override
  Future<List<PlayerModel>> getStats() async {
    if (await _networkInfo.isConnected) {
      try {
        final statsSnapshot =
            await _firebaseDatabase.ref().child('/players').once();
        final stats = statsSnapshot.snapshot.value as Map<dynamic, dynamic>;
        final List<PlayerModel> playerIds = [];

        for (var key in stats.keys) {
          final event =
              await _firebaseDatabase.ref().child('/players/$key').once();
          final statistic = PlayerModel.fromJson(Map<String, dynamic>.from(
              event.snapshot.value as Map<dynamic, dynamic>));
          playerIds.add(statistic);
        }

        print(playerIds);
        return playerIds;
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
  Future<void> updateStats(String id, StatisticModel statisticModel) async {
    if (await _networkInfo.isConnected) {
      try {
        final map = statisticModel.toJson();
        await _firebaseDatabase
            .ref()
            .child('/players/$id/statistic')
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
