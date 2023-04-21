import 'package:answer_five/core/errors/failures.dart';
import 'package:answer_five/core/usecases/usecase.dart';
import 'package:answer_five/features/authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/success.dart';

class RegisterUserWithEmailAndPassword
    implements UseCase<Success, EmailAndPasswordParams> {
  final AuthRepository _authRepository;

  const RegisterUserWithEmailAndPassword(this._authRepository);

  @override
  Future<Either<Failure, Success>> call(EmailAndPasswordParams params) async {
    final email = params.email.trim();
    final password = params.password.trim();

    return await _authRepository.registerUserWithEmailAndPassword(
        email, password);
  }
}
