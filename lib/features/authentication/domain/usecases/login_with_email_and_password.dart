import 'package:answer_five/core/errors/failures.dart';
import 'package:answer_five/core/usecases/usecase.dart';
import 'package:answer_five/features/authentication/domain/entities/player.dart';
import 'package:answer_five/features/authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/success.dart';

class LoginWithEmailAndPassword
    implements UseCase<Success, EmailAndPasswordParams> {
  final AuthRepository _authRepository;

  const LoginWithEmailAndPassword(this._authRepository);

  @override
  Future<Either<Failure, Success>> call(EmailAndPasswordParams params) async {
    return await _authRepository.loginWithEmailAndPassword(
        params.email, params.password);
  }
}
