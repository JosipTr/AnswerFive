import 'dart:io';

import 'package:answer_five/core/utils/theme/custom_theme.dart';
import 'package:answer_five/features/camera/presentation/bloc/camera_bloc.dart';
import 'package:answer_five/features/camera/presentation/bloc/camera_event.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/camera_state.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    context.read<CameraBloc>().add(const CameraInitialized());
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<CameraBloc>().add(const CameraCaptured()),
        child: const Icon(Icons.camera_alt),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop();
          return false;
        },
        child: GradientBackground(
          child: Center(
            child: BlocConsumer<CameraBloc, CameraState>(
              listener: (context, state) {
                if (state is CameraCaptureSuccess) {
                  Navigator.of(context).pop();
                } else if (state is CameraCaptureFailure) {
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                if (state is CameraReady) {
                  return SizedBox(
                      height: height, child: CameraPreview(state.controller));
                } else if (state is CameraFailure) {
                  return Text(state.message);
                }
                // else if (state is CameraCaptureSuccess) {
                //   return SizedBox(
                //       height: height,
                //       child: Image.file(
                //         File(state.path),
                //         height: height,
                //       ));
                // }
                else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
