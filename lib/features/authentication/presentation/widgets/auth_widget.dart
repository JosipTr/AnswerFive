import 'package:answer_five/features/authentication/presentation/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text('Email'),
        TextField(
          controller: emailController,
        ),
        const Text('Password'),
        TextField(
          controller: passwordController,
        ),
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state.authFilter == AuthFilter.registration) {
              final confirmPasswordController = TextEditingController();
              return Column(
                children: [
                  const Text('Confirm Password'),
                  TextField(
                    controller: confirmPasswordController,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthRegisterPressed(
                          email: emailController.text,
                          password: passwordController.text,
                          confirmedPassword: confirmPasswordController.text));
                    },
                    child: const Text('Register'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<AuthBloc>()
                          .add(const AuthPageFiltered(AuthFilter.login));
                    },
                    child: const Text('Login Page'),
                  )
                ],
              );
            } else {
              return Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthLoginPressed(
                          email: emailController.text,
                          password: passwordController.text));
                    },
                    child: const Text('Login'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<AuthBloc>()
                          .add(const AuthPageFiltered(AuthFilter.registration));
                    },
                    child: const Text('Register Page'),
                  )
                ],
              );
            }
          },
        ),
      ],
    );
  }
}
