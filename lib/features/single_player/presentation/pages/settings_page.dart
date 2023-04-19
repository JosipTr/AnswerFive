import 'package:answer_five/core/utils/theme/custom_theme.dart';
import 'package:answer_five/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:answer_five/features/authentication/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoadSuccess) {
                  return SettingsWidget(state: state);
                } else if (state is AuthLoading) {
                  return const CircularProgressIndicator();
                } else if (state is AuthLoadFailure) {
                  return Text(state.errorMessage);
                } else {
                  return const Text('Nothing');
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({
    super.key,
    required this.state,
  });

  final AuthLoadSuccess state;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
