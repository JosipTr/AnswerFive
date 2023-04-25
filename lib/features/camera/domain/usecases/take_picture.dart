import 'package:answer_five/core/errors/failures.dart';
import 'package:answer_five/core/usecases/usecase.dart';
import 'package:answer_five/features/camera/domain/repositories/camera_repository.dart';
import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';

class TakePicture implements UseCase<XFile, NoParams> {
  final CameraRepository _cameraRepository;

  const TakePicture(this._cameraRepository);

  @override
  Future<Either<Failure, XFile>> call(NoParams params) async {
    return await _cameraRepository.takePicture();
  }
}
