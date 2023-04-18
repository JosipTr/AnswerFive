import 'package:answer_five/core/errors/failures.dart';
import 'package:answer_five/core/success.dart';
import 'package:dartz/dartz.dart';

import '../entities/statistic.dart';

abstract class StatsRepository {
  Future<Either<Failure, Statistic>> getStats(String id);

  Future<Either<Failure, Success>> updateStats(String id);

  Future<Either<Failure, Success>> createStats(String id);
}
