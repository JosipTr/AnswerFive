import 'package:answer_five/features/statistic/data/datasources/stats_remote_data_source.dart';

import 'package:answer_five/core/success.dart';
import 'package:answer_five/core/errors/failures.dart';
import 'package:answer_five/features/statistic/data/models/statistic_model.dart';
import 'package:answer_five/features/statistic/domain/repositories/stats_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/statistic.dart';

class StatsRepositoryImpl implements StatsRepository {
  final StatsRemoteDataSource _dataSource;

  const StatsRepositoryImpl(this._dataSource);
  @override
  Future<Either<Failure, Statistic>> getStats(String id) async {
    try {
      final stats = await _dataSource.getStats(id);
      return Right(stats);
    } on NetworkException catch (error) {
      return Left(NetworkFailure(error.message));
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, Success>> updateStats(
      String id, Statistic statistic) async {
    try {
      final statisticModel = StatisticModel.fromStatistic(statistic);
      await _dataSource.updateStats(id, statisticModel);
      return const Right(Success());
    } on NetworkException catch (error) {
      return Left(NetworkFailure(error.message));
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }
}
