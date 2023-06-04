import 'package:answer_five/core/utils/constants/string_constants.dart';
import 'package:answer_five/features/authentication/presentation/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import 'package:form_validator/form_validator.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneHeight = MediaQuery.of(context).size.height;
    final double imageSize;
    if (phoneHeight < 800) {
      imageSize = 350;
    } else {
      imageSize = 400;
    }
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                StringConstants.logo,
                width: imageSize,
                height: imageSize,
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) => state is AuthInitial &&
                        state.authFilter == AuthFilter.registration
                    ? const _RegistrationForm()
                    : const _LoginForm(),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 50, left: 50),
            child: TextFormField(
              validator: ValidationBuilder().email().maxLength(50).build(),
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
            child: TextFormField(
              validator: ValidationBuilder().minLength(6).build(),
              decoration: const InputDecoration(label: Icon(Icons.lock)),
              obscureText: true,
              controller: passwordController,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                context.read<AuthBloc>().add(AuthLoginPressed(
                    email: emailController.text,
                    password: passwordController.text));
              }
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
      ),
    );
  }
}

class _RegistrationForm extends StatelessWidget {
  const _RegistrationForm();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return Form(
      key: formKey,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 50, left: 50),
            child: TextFormField(
              validator: ValidationBuilder().email().maxLength(50).build(),
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
            child: TextFormField(
              validator: ValidationBuilder().minLength(6).build(),
              decoration: const InputDecoration(label: Icon(Icons.lock)),
              obscureText: true,
              controller: passwordController,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 50, left: 50, top: 15),
            child: TextFormField(
              validator: (value) {
                if (passwordController.text != value) {
                  return 'Password do not match!';
                } else if (value == null || value.isEmpty) {
                  return 'The field is required';
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                label: Icon(Icons.lock_reset),
              ),
              obscureText: true,
              controller: confirmPasswordController,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                context.read<AuthBloc>().add(AuthRegisterPressed(
                    email: emailController.text,
                    password: passwordController.text,
                    confirmedPassword: confirmPasswordController.text));
              }
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
      ),
    );
  }
}
