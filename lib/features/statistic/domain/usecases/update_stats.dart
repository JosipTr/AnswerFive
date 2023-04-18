import 'package:answer_five/core/errors/failures.dart';
import 'package:answer_five/core/success.dart';
import 'package:answer_five/core/usecases/usecase.dart';
import 'package:answer_five/features/statistic/domain/repositories/stats_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateStats extends UseCase<Success, StatsParams> {
  final StatsRepository _repository;

  UpdateStats(this._repository);

  @override
  Future<Either<Failure, Success>> call(StatsParams params) async {
    return await _repository.updateStats(params.id);
  }
}
