import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';

abstract class CameraState extends Equatable {
  const CameraState();
}

class CameraInitial extends CameraState {
  const CameraInitial();

  @override
  List<Object> get props => [];
}

class CameraReady extends CameraState {
  final CameraController controller;
  const CameraReady(this.controller);

  @override
  List<Object> get props => [controller];
}

class CameraFailure extends CameraState {
  final String message;
  const CameraFailure(this.message);

  @override
  List<Object> get props => [message];
}

class CameraCaptureInProgress extends CameraState {
  const CameraCaptureInProgress();

  @override
  List<Object> get props => [];
}

class CameraCaptureSuccess extends CameraState {
  final String path;
  const CameraCaptureSuccess(this.path);

  @override
  List<Object> get props => [path];
}

class CameraCaptureFailure extends CameraState {
  final String message;
  const CameraCaptureFailure(this.message);

  @override
  List<Object> get props => [message];
}
