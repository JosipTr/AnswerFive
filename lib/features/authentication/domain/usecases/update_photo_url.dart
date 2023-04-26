import 'package:answer_five/core/errors/failures.dart';
import 'package:answer_five/core/success.dart';
import 'package:answer_five/core/usecases/usecase.dart';
import 'package:answer_five/features/authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class UpdatePhotoURL implements UseCase<Success, UpdatePhotoUrlParams> {
  final AuthRepository _authRepository;

  const UpdatePhotoURL(this._authRepository);

  @override
  Future<Either<Failure, Success>> call(UpdatePhotoUrlParams params) async {
    return await _authRepository.updatePhotoURL(params);
  }
}
