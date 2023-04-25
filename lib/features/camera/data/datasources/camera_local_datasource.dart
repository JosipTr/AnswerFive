import 'package:camera/camera.dart';

abstract class CameraLocalDatasource {
  CameraController getCameraController();
}

class CameraLocalDatasourceImpl implements CameraLocalDatasource {
  final CameraDescription _camera;

  const CameraLocalDatasourceImpl(this._camera);

  @override
  CameraController getCameraController() {
    return CameraController(_camera, ResolutionPreset.medium);
  }
}
