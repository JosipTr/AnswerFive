import 'package:answer_five/core/errors/failures.dart';
import 'package:answer_five/core/usecases/usecase.dart';
import 'package:answer_five/features/authentication/domain/entities/player.dart';
import 'package:answer_five/features/authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class RegisterUserWithEmailAndPassword
    implements UseCase<Player, EmailAndPasswordParams> {
  final AuthRepository _authRepository;

  const RegisterUserWithEmailAndPassword(this._authRepository);

  @override
  Future<Either<Failure, Player>> call(EmailAndPasswordParams params) async {
    final email = params.email.trim();
    final password = params.password.trim();
    final confirmedPassword = params.password.trim();
    if (!email.contains('@')) {
      return const Left(InputFailure('Registration Failed!'));
    } else if (password.length < 6) {
      return const Left(InputFailure('Password is too short!'));
    } else if (password != confirmedPassword) {
      return const Left(InputFailure('Passwords do not match!'));
    } else {
      return await _authRepository.registerUserWithEmailAndPassword(
          params.email, params.password);
    }
  }
}
