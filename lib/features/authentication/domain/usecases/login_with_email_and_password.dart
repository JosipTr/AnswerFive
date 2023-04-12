import 'package:answer_five/core/errors/failures.dart';
import 'package:answer_five/core/usecases/usecase.dart';
import 'package:answer_five/features/authentication/domain/entities/player.dart';
import 'package:answer_five/features/authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LoginWithEmailAndPassword
    implements UseCase<Player, EmailAndPasswordParams> {
  final AuthRepository _authRepository;

  const LoginWithEmailAndPassword(this._authRepository);

  @override
  Future<Either<Failure, Player>> call(EmailAndPasswordParams params) async {
    return await _authRepository.loginWithEmailAndPassword(
        params.email, params.password);
  }
}
