import 'package:answer_five/core/errors/failures.dart';
import 'package:answer_five/core/success.dart';
import 'package:answer_five/core/usecases/usecase.dart';
import 'package:answer_five/features/authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateUsername implements UseCase<Success, String> {
  final AuthRepository _authRepository;

  const UpdateUsername(this._authRepository);

  @override
  Future<Either<Failure, Success>> call(String username) async {
    return await _authRepository.updateUsername(username);
  }
}
