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
    return await _repository.getTrivia();
  }
}
