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
          final either = await _repository.getTrivia();
          return either.fold((failure) => Left(failure), (trivia) async {
            await _repository.updateTodayQuestionNumber();
            trivia.answers.shuffle();
            return Right(trivia);
          });
        }
      } else {
        return const Left(InputFailure('No more questions left!'));
      }
    });
  }
}
