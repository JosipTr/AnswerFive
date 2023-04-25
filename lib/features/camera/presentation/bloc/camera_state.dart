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
  const CameraReady();

  @override
  List<Object> get props => [];
}
