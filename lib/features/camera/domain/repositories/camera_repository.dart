import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/success.dart';

abstract class CameraRepository {
  Future<Either<Failure, CameraController>> initializeCamera();
}
