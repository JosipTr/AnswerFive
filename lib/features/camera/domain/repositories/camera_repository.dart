import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class CameraRepository {
  Future<Either<Failure, CameraController>> initializeCamera();

  Future<Either<Failure, XFile>> takePicture();
}
