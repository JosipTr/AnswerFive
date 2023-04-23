import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/success.dart';
import '../entities/trivia.dart';

abstract class TriviaRepository {
  Future<Either<Failure, Trivia>> getTrivia();

  Future<Either<Failure, int>> getTodayQuestionNumber();

  Future<Either<Failure, Success>> updateTodayQuestionNumber();
}
