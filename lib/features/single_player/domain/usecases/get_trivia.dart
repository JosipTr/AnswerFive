import 'package:answer_five/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase.dart';

import '../entities/trivia.dart';
import '../repositories/trivia_repository.dart';

class GetTrivia implements UseCase<Trivia, NoParams> {
  final TriviaRepository _repository;

  const GetTrivia(this._repository);

  @override
  Future<Either<Failure, Trivia>> call(NoParams params) async {
    final eitherCheck = await _repository.getTodayQuestionNumber();

    return eitherCheck.fold((l) => Left(l), (r) async {
      if (r < 5) {
        {
          await _repository.updateTodayQuestionNumber();

          final either = await _repository.getTrivia();
          either.fold((failure) => null, (trivia) {
            trivia.answers.shuffle();
          });
          return either;
        }
      } else {
        return const Left(InputFailure('Already played today'));
      }
    });
  }
}
