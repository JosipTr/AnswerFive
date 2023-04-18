import 'package:answer_five/core/errors/failures.dart';
import 'package:answer_five/core/usecases/usecase.dart';
import 'package:answer_five/features/statistic/domain/entities/statistic.dart';
import 'package:answer_five/features/statistic/domain/repositories/stats_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../authentication/domain/entities/player.dart';

class GetStats extends UseCase<Player, StatsParams> {
  final StatsRepository _repository;

  GetStats(this._repository);
  @override
  Future<Either<Failure, Player>> call(StatsParams params) async {
    return await _repository.getStats(params.player);
  }
}
