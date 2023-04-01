import 'package:answer_five/features/authentication/core/errors/failures.dart';
import 'package:answer_five/features/authentication/core/errors/success.dart';
import 'package:answer_five/features/authentication/core/usecases/usecase.dart';
import 'package:answer_five/features/authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class Logout extends UseCase<Success, NoParams> {
  final AuthRepository _authRepository;

  Logout(this._authRepository);

  @override
  Future<Either<Failure, Success>> call(NoParams params) async {
    return await _authRepository.logout();
  }
}
