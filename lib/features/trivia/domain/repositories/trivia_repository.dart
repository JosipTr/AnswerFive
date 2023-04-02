import 'package:dartz/dartz.dart';

import '../../core/errors/failures/server_failure.dart';
import '../entities/trivia.dart';

abstract class TriviaRepository {
  Future<Either<Failure, Trivia>> getTrivia();
}
