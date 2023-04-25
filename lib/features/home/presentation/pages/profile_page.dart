import 'package:answer_five/core/utils/theme/custom_theme.dart';
import 'package:answer_five/features/camera/presentation/bloc/camera_bloc.dart';
import 'package:answer_five/features/camera/presentation/bloc/camera_event.dart';
import 'package:answer_five/features/home/presentation/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                  const CircleAvatar(
                    radius: 100,
                    child: Text('Image'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 25,
                    child: IconButton(
                        onPressed: () {
                          context.read<CameraBloc>().add(const CameraStarted());
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
