import 'package:answer_five/core/usecases/usecase.dart';
import 'package:answer_five/features/camera/domain/usecases/initialize_camera.dart';
import 'package:answer_five/features/camera/domain/usecases/take_picture.dart';
import 'package:answer_five/features/camera/presentation/bloc/camera_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'camera_event.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  final InitializeCamera _initializeCamera;
  final TakePicture _takePicture;

  CameraBloc(this._initializeCamera, this._takePicture)
      : super(const CameraInitial()) {
    on<CameraInitialized>(_onCameraInitialized);
    on<CameraCaptured>(_onCameraCaptured);
  }
  Future<void> _onCameraInitialized(
      CameraInitialized event, Emitter<CameraState> emit) async {
    final either = await _initializeCamera(const NoParams());

    either.fold((failure) {
      emit(CameraFailure(failure.message));
    }, (controller) => emit(CameraReady(controller)));
  }

  Future<void> _onCameraCaptured(
      CameraCaptured event, Emitter<CameraState> emit) async {
    final either = await _takePicture(const NoParams());
    if (state is CameraReady) {
      emit(const CameraCaptureInProgress());
      either.fold((l) {
        emit(CameraCaptureFailure(l.message));
      }, (r) {
        emit(CameraCaptureSuccess(r.path));
      });
    }
  }
}
