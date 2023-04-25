import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class PickerState extends Equatable {
  const PickerState();
}

class PickerInitial extends PickerState {
  const PickerInitial();

  @override
  List<Object> get props => [];
}

class PickerLoadSuccess extends PickerState {
  final XFile? xFile;
  const PickerLoadSuccess(this.xFile);

  @override
  List<Object?> get props => [xFile];
}

class PickerLoadFailure extends PickerState {
  final String message;
  const PickerLoadFailure(this.message);

  @override
  List<Object> get props => [message];
}

class PickerLoading extends PickerState {
  const PickerLoading();

  @override
  List<Object> get props => [];
}
