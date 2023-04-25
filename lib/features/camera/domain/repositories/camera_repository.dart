import 'package:answer_five/features/camera/data/datasources/camera_local_datasource.dart';
import 'package:camera/camera.dart';

class CameraRepository {
  final CameraLocalDatasource _datasource;

  const CameraRepository(this._datasource);
  CameraController getCameraController() {
    return _datasource.getCameraController();
  }
}
