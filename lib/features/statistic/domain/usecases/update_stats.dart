import 'package:answer_five/core/errors/failures.dart';
import 'package:answer_five/core/success.dart';
import 'package:answer_five/core/usecases/usecase.dart';
import 'package:answer_five/features/statistic/domain/entities/statistic.dart';
import 'package:answer_five/features/statistic/domain/repositories/stats_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateStats extends UseCase<Success, StatsParams> {
  final StatsRepository _repository;

  UpdateStats(this._repository);

  @override
  Future<Either<Failure, Success>> call(StatsParams params) async {
    var totalQuestions = 0;
    final player = await _repository.getStats(params.player);
    player.fold(
        (l) => null, (r) => totalQuestions = r.statistic.totalQuestions + 1);
    final stats =
        params.player.statistic.copyWith(totalQuestions: totalQuestions);
    final newPlayer = params.player.copyWith(statistic: stats);
    return await _repository.updateStats(newPlayer);
  }
}
