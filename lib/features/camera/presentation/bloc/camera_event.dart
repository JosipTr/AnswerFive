import 'package:equatable/equatable.dart';

abstract class CameraEvent extends Equatable {
  const CameraEvent();
}

class CameraInitialized extends CameraEvent {
  const CameraInitialized();

  @override
  List<Object> get props => [];
}

class CameraStarted extends CameraEvent {
  const CameraStarted();

  @override
  List<Object> get props => [];
}
