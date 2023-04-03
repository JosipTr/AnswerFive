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
      imageSize = 500;
    }
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              Image.asset(
                "assets/images/answer_five_nobackground.png",
                width: imageSize,
                height: imageSize,
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state.authFilter == AuthFilter.registration) {
                    return const _RegistrationForm();
                  } else {
                    return const _LoginForm();
                  }
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Form(
      key: _formKey,
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
              if (_formKey.currentState!.validate()) {
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

class _RegistrationForm extends StatefulWidget {
  const _RegistrationForm();

  @override
  State<_RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<_RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    return Form(
      key: _formKey,
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
            margin: const EdgeInsets.only(right: 50, left: 50, top: 5),
            child: TextFormField(
              validator: ValidationBuilder().minLength(6).build(),
              decoration: const InputDecoration(label: Icon(Icons.lock)),
              obscureText: true,
              controller: passwordController,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 50, left: 50, top: 5),
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
              controller: confirmPasswordController,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
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
