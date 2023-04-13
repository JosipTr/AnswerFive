import 'package:answer_five/features/authentication/domain/entities/statistic.dart';
import 'package:dartz/dartz.dart';

import '../../features/authentication/domain/entities/player.dart';
import '../errors/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {
  const NoParams();
}

class EmailAndPasswordParams {
  final String email;
  final String password;
  final String? confirmedPassword;

  const EmailAndPasswordParams(
      {required this.email, required this.password, this.confirmedPassword});
}

class StatsParams {
  final Player player;
  const StatsParams(this.player);
}
