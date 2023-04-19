import 'package:answer_five/core/errors/failures.dart';
import 'package:answer_five/core/success.dart';
import 'package:answer_five/core/usecases/usecase.dart';
import 'package:answer_five/features/statistic/domain/repositories/stats_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateStats extends UseCase<Success, StatsParams> {
  final StatsRepository _repository;

  UpdateStats(this._repository);

  @override
  Future<Either<Failure, Success>> call(StatsParams params) async {
    if (params.isCorrect!) {
      final either = await _repository.getStats(params.id);
      return either.fold((failure) => Left(failure), (statistic) async {
        final correctAnswers = statistic.correctAnswers + 1;
        final totalQuestions = statistic.totalQuestions + 1;
        final stats = statistic.copyWith(
            correctAnswers: correctAnswers, totalQuestions: totalQuestions);
        await _repository.updateStats(params.id, stats);
        return const Right(Success());
      });
    } else {
      final either = await _repository.getStats(params.id);
      return either.fold((failure) => Left(failure), (statistic) async {
        final incorrectAnswers = statistic.incorrectAnswers + 1;
        final totalQuestions = statistic.totalQuestions + 1;
        final stats = statistic.copyWith(
            incorrectAnswers: incorrectAnswers, totalQuestions: totalQuestions);
        await _repository.updateStats(params.id, stats);
        return const Right(Success());
      });
    }
  }
}
