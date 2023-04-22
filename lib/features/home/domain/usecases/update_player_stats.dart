import 'package:answer_five/core/errors/failures.dart';
import 'package:answer_five/core/success.dart';
import 'package:answer_five/core/usecases/usecase.dart';
import 'package:answer_five/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class UpdatePlayerStats implements UseCase<Success, UpdatePlayerStatsParams> {
  final HomeRepository _homeRepository;

  const UpdatePlayerStats(this._homeRepository);

  @override
  Future<Either<Failure, Success>> call(UpdatePlayerStatsParams params) async {
    if (params.isCorrect) {
      final correctAnswer = params.statistic.correctAnswers + 1;
      final totalQuestions = params.statistic.totalQuestions + 1;
      final statistic = params.statistic.copyWith(
          correctAnswers: correctAnswer, totalQuestions: totalQuestions);
      return await _homeRepository.updatePlayerStats(statistic);
    } else {
      final incorrectAnswer = params.statistic.incorrectAnswers + 1;
      final totalQuestions = params.statistic.totalQuestions + 1;
      final statistic = params.statistic.copyWith(
          incorrectAnswers: incorrectAnswer, totalQuestions: totalQuestions);
      return await _homeRepository.updatePlayerStats(statistic);
    }
  }
}
