import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/trivia.dart';

abstract class TriviaRepository {
  Future<Either<Failure, Trivia>> getTrivia();
}
