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
      body: SingleChildScrollView(
        child: GradientBackground(
          child: SafeArea(
            child: BlocConsumer<AuthBloc, AuthState>(
              listenWhen: (previous, current) =>
                  previous.authStatus != current.authStatus,
              listener: (context, state) {
                if (state.authStatus == AuthStatus.failure) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                        SnackBar(content: Text(state.failureMessage!)));
                }
              },
              builder: (context, state) {
                if (state.authStatus == AuthStatus.initial) {
                  return const AuthWidget();
                } else if (state.authStatus == AuthStatus.success) {
                  return const HomePage();
                } else if (state.authStatus == AuthStatus.loading) {
                  return const CircularProgressIndicator();
                } else {
                  return const AuthWidget();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class GradientBackground extends StatelessWidget {
  final Widget child;
  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final phoneHeight = MediaQuery.of(context).size.height;
    return Container(
      height: phoneHeight,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(255, 222, 89, 1),
            Color.fromRGBO(255, 102, 196, 1)
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          tileMode: TileMode.mirror,
        ),
      ),
      child: child,
    );
  }
}