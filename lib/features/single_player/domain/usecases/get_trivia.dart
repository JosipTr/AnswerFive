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
    final eitherCheck = await _repository.checkTodayQuestionNumber();

    return eitherCheck.fold((l) => const Left(InputFailure('OOps')), (r) async {
      if (r < 5) {
        {
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
