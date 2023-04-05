import 'package:answer_five/core/utils/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication/presentation/bloc/auth_bloc.dart';
import '../../../authentication/presentation/bloc/auth_event.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneHeight = MediaQuery.of(context).size.height;
    final double imageSize;
    if (phoneHeight < 800) {
      imageSize = 350;
    } else {
      imageSize = 500;
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            StringConstants.logo,
            width: imageSize,
            height: imageSize,
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
