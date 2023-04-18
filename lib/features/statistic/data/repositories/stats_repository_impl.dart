import 'package:answer_five/features/statistic/data/datasources/stats_remote_data_source.dart';
import 'package:answer_five/features/statistic/data/models/statistic_model.dart';
import 'package:answer_five/features/statistic/domain/entities/statistic.dart';
import 'package:answer_five/core/success.dart';
import 'package:answer_five/core/errors/failures.dart';
import 'package:answer_five/features/statistic/domain/repositories/stats_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../authentication/domain/entities/player.dart';
import '../../../authentication/data/models/player_model.dart';

class StatsRepositoryImpl implements StatsRepository {
  final StatsRemoteDataSource _dataSource;

  const StatsRepositoryImpl(this._dataSource);
  @override
  Future<Either<Failure, Player>> getStats(Player player) async {
    try {
      final playerModel = PlayerModel.fromPlayer(player);
      final stats = await _dataSource.getStats(playerModel);
      return Right(stats);
    } on NetworkException catch (error) {
      return Left(NetworkFailure(error.message));
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, Success>> updateStats(Player player) async {
    try {
      final playerModel = PlayerModel.fromPlayer(player);

      await _dataSource.updateStats(playerModel);
      return const Right(Success());
    } on NetworkException catch (error) {
      return Left(NetworkFailure(error.message));
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }
}
