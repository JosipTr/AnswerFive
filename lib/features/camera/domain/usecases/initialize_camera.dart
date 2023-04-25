import 'package:answer_five/core/errors/failures.dart';
import 'package:answer_five/core/success.dart';
import 'package:answer_five/core/usecases/usecase.dart';
import 'package:answer_five/features/camera/domain/repositories/camera_repository.dart';
import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';

class InitializeCamera extends UseCase<CameraController, NoParams> {
  final CameraRepository _cameraRepository;

  InitializeCamera(this._cameraRepository);

  @override
  Future<Either<Failure, CameraController>> call(NoParams params) async {
    return await _cameraRepository.initializeCamera();
  }
}
