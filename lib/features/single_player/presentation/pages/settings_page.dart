import 'package:answer_five/core/utils/theme/custom_theme.dart';
import 'package:answer_five/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:answer_five/features/authentication/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<AuthBloc>().state as AuthLoadSuccess;
    return Scaffold(
      body: GradientBackground(
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CircleAvatar(
                  radius: 100,
                  child: Text('Image'),
                ),
                Text('User uid: ${state.user.id}'),
                Text('Email: ${state.user.email}'),
                Text('Username: ${state.user.name}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Email verified: '),
                    state.user.emailVerified
                        ? const Icon(Icons.check, color: Colors.green)
                        : const Icon(
                            Icons.dangerous,
                            color: Colors.red,
                          )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
