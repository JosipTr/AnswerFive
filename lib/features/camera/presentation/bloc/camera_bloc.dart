import 'dart:developer';

import 'package:answer_five/features/camera/domain/repositories/camera_repository.dart';
import 'package:answer_five/features/camera/presentation/bloc/camera_state.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'camera_event.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  final CameraRepository _cameraRepository;

  late CameraController _controller;

  CameraBloc(this._cameraRepository) : super(const CameraInitial()) {
    on<CameraStarted>(
      (event, emit) async {
        try {
          _controller = _cameraRepository.getCameraController();
          await _controller.initialize();
          log(_controller.toString());
          emit(CameraReady(_controller));
        } on CameraException catch (error) {
          await _cameraRepository.getCameraController().dispose();
          log(error.toString());
          emit(CameraFailure(error.toString()));
        }
      },
    );
  }
}
