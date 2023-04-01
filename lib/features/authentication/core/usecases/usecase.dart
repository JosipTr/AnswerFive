import 'package:dartz/dartz.dart';

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
