import 'package:equatable/equatable.dart';

abstract class PickerEvent extends Equatable {
  const PickerEvent();
}

class PickerStarted extends PickerEvent {
  const PickerStarted();

  @override
  List<Object> get props => [];
}

class PickerImagePicked extends PickerEvent {
  const PickerImagePicked();

  @override
  List<Object> get props => [];
}

class PickerCameraPicked extends PickerEvent {
  const PickerCameraPicked();

  @override
  List<Object> get props => [];
}
