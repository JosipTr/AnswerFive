import 'dart:developer';

import 'package:answer_five/core/usecases/usecase.dart';
import 'package:answer_five/features/camera/domain/usecases/initialize_camera.dart';
import 'package:answer_five/features/camera/presentation/bloc/camera_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'camera_event.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  final InitializeCamera _initializeCamera;

  CameraBloc(this._initializeCamera) : super(const CameraInitial()) {
    on<CameraInitialized>(_onCameraInitialized);
  }
  Future<void> _onCameraInitialized(
      CameraInitialized event, Emitter<CameraState> emit) async {
    final either = await _initializeCamera(const NoParams());

    either.fold((failure) => emit(CameraFailure(failure.message)),
        (controller) => emit(CameraReady(controller)));
  }
}
