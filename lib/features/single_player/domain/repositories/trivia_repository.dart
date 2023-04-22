import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/trivia.dart';

abstract class TriviaRepository {
  Future<Either<Failure, Trivia>> getTrivia();

  Future<Either<Failure, int>> checkTodayQuestionNumber();

  Future<Either<Failure, String>> checkLastActive();
}
