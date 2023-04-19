import 'dart:developer';

import 'package:answer_five/core/network/network_info.dart';
import 'package:answer_five/features/statistic/data/models/statistic_model.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/constants/string_constants.dart';

abstract class StatsRemoteDataSource {
  Future<StatisticModel> getStats(String id);
  Future<void> updateStats(String id, StatisticModel statisticModel);
}

class StatsRemoteDataSourceImpl implements StatsRemoteDataSource {
  final FirebaseDatabase _firebaseDatabase;
  final NetworkInfo _networkInfo;

  const StatsRemoteDataSourceImpl(this._firebaseDatabase, this._networkInfo);
  @override
  Future<StatisticModel> getStats(String id) async {
    if (await _networkInfo.isConnected) {
      try {
        final statsSnapshot = await _firebaseDatabase
            .ref()
            .child('/players/$id/statistic')
            .once();
        final stats = StatisticModel.fromJson(Map<String, dynamic>.from(
            statsSnapshot.snapshot.value as Map<dynamic, dynamic>));

        return stats;
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
