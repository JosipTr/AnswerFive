import 'package:answer_five/core/utils/theme/custom_theme.dart';
import 'package:answer_five/features/camera/presentation/bloc/camera_bloc.dart';
import 'package:answer_five/features/camera/presentation/bloc/camera_event.dart';
import 'package:answer_five/features/home/presentation/bloc/home_state.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../camera/presentation/bloc/camera_state.dart';
import '../bloc/home_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final player = (context.read<HomeBloc>().state as HomeLoadSuccess).player;
    return BlocBuilder<CameraBloc, CameraState>(
      builder: (context, state) {
        if (state is CameraInitial) {
          return Scaffold(
            body: GradientBackground(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Stack(
                      children: [
                        const CircleAvatar(
                          radius: 100,
                          child: Text('Image'),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 25,
                          child: IconButton(
                              onPressed: () {
                                context
                                    .read<CameraBloc>()
                                    .add(const CameraInitialized());
                              },
                              icon: const Icon(Icons.camera_alt)),
                        ),
                      ],
                    ),
                    Text(
                      'UserId:\n${player.id}',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Username:\n${player.name}',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Email:\n${player.email}',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is CameraReady) {
          return CameraPreview(state.controller);
        } else {
          return Text('no');
        }
      },
    );
  }
}

// A screen that allows users to take a picture using a given camera.
