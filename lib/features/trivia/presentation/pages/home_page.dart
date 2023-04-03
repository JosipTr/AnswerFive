import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication/presentation/bloc/auth_bloc.dart';
import '../../../authentication/presentation/bloc/auth_event.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    log('home build');
    final safe = MediaQuery.of(context).padding.top;
    log(safe.toString());
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/answer_five_nobackground.png",
            width: 350,
            height: 350,
          ),
          ElevatedButton(onPressed: () {}, child: const Text('Single Player')),
          ElevatedButton(onPressed: () {}, child: const Text('Multi Player')),
          ElevatedButton(onPressed: () {}, child: const Text('Settings')),
          ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(const AuthLogoutPressed());
              },
              child: const Text('Logout')),
        ],
      ),
    );
  }
}
