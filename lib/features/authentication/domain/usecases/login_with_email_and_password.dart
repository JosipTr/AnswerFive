import 'package:answer_five/features/authentication/core/errors/failures.dart';
import 'package:answer_five/features/authentication/core/usecases/usecase.dart';
import 'package:answer_five/features/authentication/domain/entities/trivia_user.dart';
import 'package:answer_five/features/authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LoginWithEmailAndPassword
    implements UseCase<TriviaUser, EmailAndPasswordParams> {
  final AuthRepository _authRepository;

  const LoginWithEmailAndPassword(this._authRepository);

  @override
  Future<Either<Failure, TriviaUser>> call(
      EmailAndPasswordParams params) async {
    return await _authRepository.loginWithEmailAndPassword(
        params.email, params.password);
  }
}
