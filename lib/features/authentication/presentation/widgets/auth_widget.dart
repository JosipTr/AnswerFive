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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/answer_five_nobackground.png",
          width: 350,
          height: 350,
        ),
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state.authFilter == AuthFilter.registration) {
              final confirmPasswordController = TextEditingController();
              return _RegistrationForm(
                  emailController: emailController,
                  passwordController: passwordController,
                  confirmPasswordController: confirmPasswordController);
            } else {
              return _LoginForm(
                  emailController: emailController,
                  passwordController: passwordController);
            }
          },
        ),
      ],
    );
  }
}

class _LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const _LoginForm(
      {required this.emailController, required this.passwordController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 50, left: 50),
          child: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'example@example.com',
              label: Icon(Icons.email),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 50, left: 50, top: 15),
          child: TextField(
            decoration: const InputDecoration(label: Icon(Icons.lock)),
            obscureText: true,
            controller: passwordController,
          ),
        ),
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
}

class _RegistrationForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  const _RegistrationForm(
      {required this.emailController,
      required this.passwordController,
      required this.confirmPasswordController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 50, left: 50),
          child: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'example@example.com',
              label: Icon(Icons.email),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 50, left: 50, top: 5),
          child: TextField(
            decoration: const InputDecoration(label: Icon(Icons.lock)),
            obscureText: true,
            controller: passwordController,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 50, left: 50, top: 5),
          child: TextField(
            decoration: const InputDecoration(label: Icon(Icons.check)),
            controller: confirmPasswordController,
          ),
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
  }
}
