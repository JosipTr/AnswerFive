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
