import 'package:answer_five/core/errors/failures.dart';
import 'package:answer_five/core/success.dart';
import 'package:dartz/dartz.dart';

import '../../../authentication/domain/entities/player.dart';
import '../entities/statistic.dart';

abstract class StatsRepository {
  Future<Either<Failure, List<Player>>> getStats();

  Future<Either<Failure, Success>> updateStats(String id, Statistic statistic);
}
