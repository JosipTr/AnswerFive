import 'package:answer_five/core/utils/theme/custom_theme.dart';
import 'package:answer_five/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:answer_five/features/authentication/presentation/widgets/auth_widget.dart';
import 'package:answer_five/features/trivia/presentation/pages/home_page.dart';
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
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state.authStatus == AuthStatus.success) {
                return const HomePage();
              } else if (state.authStatus == AuthStatus.loading) {
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
