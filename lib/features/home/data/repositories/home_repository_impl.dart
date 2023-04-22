import 'package:answer_five/core/errors/exceptions.dart';
import 'package:answer_five/core/success.dart';
import 'package:answer_five/core/errors/failures.dart';
import 'package:answer_five/features/authentication/domain/entities/player.dart';
import 'package:answer_five/features/home/data/datasources/home_remote_datasource.dart';
import 'package:answer_five/features/home/domain/repositories/home_repository.dart';
import 'package:answer_five/features/statistic/data/models/statistic_model.dart';
import 'package:dartz/dartz.dart';
import 'package:answer_five/features/statistic/domain/entities/statistic.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDatasource _datasource;

  const HomeRepositoryImpl(this._datasource);

  @override
  Stream<Player> getPlayer() {
    final playerModel = _datasource.getPlayer();
    return playerModel.map((playerModel) => playerModel.toPlayer());
  }

  @override
  Future<Either<Failure, Success>> updatePlayerStats(
      Statistic statistic) async {
    try {
      final statisticModel = StatisticModel.fromStatistic(statistic);
      await _datasource.updatePlayerStats(statisticModel);
      return const Right(Success());
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on NetworkException catch (error) {
      return Left(NetworkFailure(error.message));
    }
  }
}
