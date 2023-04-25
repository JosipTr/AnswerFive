import 'dart:io';

import 'package:answer_five/core/utils/theme/custom_theme.dart';
import 'package:answer_five/features/home/presentation/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../camera/presentation/bloc/camera_bloc.dart';
import '../../../camera/presentation/bloc/camera_state.dart';
import '../../../camera/presentation/presentation/camera_page.dart';
import '../bloc/home_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final player = (context.read<HomeBloc>().state as HomeLoadSuccess).player;

    return Scaffold(
      body: GradientBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                children: [
                  BlocBuilder<CameraBloc, CameraState>(
                    builder: (context, state) {
                      if (state is CameraCaptureSuccess) {
                        return CircleAvatar(
                          backgroundImage: FileImage(
                            File(state.path),
                          ),
                          radius: 100,
                        );
                      } else {
                        return const CircleAvatar(
                          radius: 100,
                          child: Text('Image'),
                        );
                      }
                    },
                  ),
                  Positioned(
                    bottom: -15,
                    right: 5,
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const CameraPage(),
                          ));
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
  }
}

// A screen that allows users to take a picture using a given camera.
