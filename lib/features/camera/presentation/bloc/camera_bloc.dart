import 'package:answer_five/features/camera/domain/repositories/camera_repository.dart';
import 'package:answer_five/features/camera/presentation/bloc/camera_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'camera_event.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  final CameraRepository _cameraRepository;

  CameraBloc(this._cameraRepository) : super(const CameraInitial()) {
    on<CameraStarted>(
      (event, emit) {
        _cameraRepository.getCameraController().initialize();
        emit(CameraReady());
      },
    );
  }
}
