import 'dart:developer';

import 'package:camera/camera.dart';

import '../../../../core/errors/exceptions.dart';

abstract class CameraLocalDatasource {
  Future<CameraController> initializeCamera();
}

class CameraLocalDatasourceImpl implements CameraLocalDatasource {
  final CameraController _cameraController;

  const CameraLocalDatasourceImpl(this._cameraController);

  @override
  Future<CameraController> initializeCamera() async {
    try {
      await _cameraController.initialize();
      return _cameraController;
    } catch (error, stackTrace) {
      log(error: error, stackTrace: stackTrace, 'initializeCamera()');
      throw const CameraExc();
    }
  }
}
