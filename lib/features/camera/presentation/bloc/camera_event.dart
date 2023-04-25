import 'package:equatable/equatable.dart';

abstract class CameraEvent extends Equatable {
  const CameraEvent();
}

class CameraInitialized extends CameraEvent {
  const CameraInitialized();

  @override
  List<Object> get props => [];
}

class CameraStopped extends CameraEvent {
  const CameraStopped();

  @override
  List<Object> get props => [];
}

class CameraCaptured extends CameraEvent {
  const CameraCaptured();

  @override
  List<Object> get props => [];
}
