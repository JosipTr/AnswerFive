import 'package:equatable/equatable.dart';

abstract class CameraEvent extends Equatable {
  const CameraEvent();
}

class CameraStarted extends CameraEvent {
  const CameraStarted();

  @override
  List<Object> get props => [];
}
