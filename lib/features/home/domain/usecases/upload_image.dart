import 'package:answer_five/core/errors/failures.dart';
import 'package:answer_five/core/success.dart';
import 'package:answer_five/core/usecases/usecase.dart';
import 'package:answer_five/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class UploadImage implements UseCase<Success, UploadImageParams> {
  final HomeRepository _homeRepository;

  const UploadImage(this._homeRepository);

  @override
  Future<Either<Failure, Success>> call(UploadImageParams params) async {
    return await _homeRepository.uploadImage(params.xFile);
  }
}
