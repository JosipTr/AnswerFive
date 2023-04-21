import 'package:answer_five/core/utils/theme/custom_theme.dart';
import 'package:answer_five/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:answer_five/features/authentication/presentation/widgets/auth_widget.dart';
import 'package:answer_five/features/home/presentation/pages/home_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_state.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Center(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthLoadFailure) {
                final messenger = ScaffoldMessenger.of(context);
                messenger
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text(state.errorMessage)));
              }
            },
            builder: (context, state) {
              if (state is AuthLoadSuccess) {
                return const HomePage();
              } else if (state is AuthLoading) {
                return const CircularProgressIndicator();
              }
              return const AuthWidget();
            },
          ),
        ),
      ),
    );
  }
}
