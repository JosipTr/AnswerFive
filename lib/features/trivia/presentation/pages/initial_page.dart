import 'package:answer_five/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:answer_five/features/authentication/presentation/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          "assets/images/answer_five_nobackground.png",
          width: 350,
          height: 350,
        ),
        ElevatedButton(onPressed: () {}, child: Text('Single Player')),
        ElevatedButton(onPressed: () {}, child: Text('Multi Player')),
        ElevatedButton(
            onPressed: () {
              context.read<AuthBloc>().add(const AuthLogoutPressed());
            },
            child: Text('Logout')),
      ],
    );
  }
}
