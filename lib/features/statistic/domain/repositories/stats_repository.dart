import 'package:answer_five/core/errors/failures.dart';
import 'package:answer_five/core/success.dart';
import 'package:answer_five/features/statistic/domain/entities/statistic.dart';
import 'package:dartz/dartz.dart';

import '../../../authentication/domain/entities/player.dart';

abstract class StatsRepository {
  Future<Either<Failure, Player>> getStats(Player player);

  Future<Either<Failure, Success>> updateStats(Player player);
}
