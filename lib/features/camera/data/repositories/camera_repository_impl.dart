import 'package:answer_five/core/errors/exceptions.dart';
import 'package:answer_five/core/errors/failures.dart';
import 'package:answer_five/features/camera/data/datasources/camera_local_datasource.dart';
import 'package:answer_five/features/camera/domain/repositories/camera_repository.dart';
import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';

class CameraRepositoryImpl implements CameraRepository {
  final CameraLocalDatasource _datasource;

  const CameraRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, CameraController>> initializeCamera() async {
    try {
      final cameraController = await _datasource.initializeCamera();
      return Right(cameraController);
    } on CameraExc catch (error) {
      return Left(CameraFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, XFile>> takePicture() async {
    try {
      final xFile = await _datasource.takePicture();
      return Right(xFile);
    } on CameraExc catch (error) {
      return Left(CameraFailure(error.message));
    }
  }
}
