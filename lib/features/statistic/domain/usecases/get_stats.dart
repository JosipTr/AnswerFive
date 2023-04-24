import 'package:answer_five/core/errors/failures.dart';
import 'package:answer_five/core/usecases/usecase.dart';
import 'package:answer_five/features/statistic/domain/repositories/stats_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../authentication/domain/entities/player.dart';

class GetStats extends UseCase<List<Player>, NoParams> {
  final StatsRepository _repository;

  GetStats(this._repository);
  @override
  Future<Either<Failure, List<Player>>> call(NoParams params) async {
    final either = await _repository.getStats();

    return either.fold((l) => Left(l), (r) {
      r.sort((a, b) =>
          b.statistic.correctAnswers.compareTo(a.statistic.correctAnswers));
      return Right(r);
    });
  }
}
