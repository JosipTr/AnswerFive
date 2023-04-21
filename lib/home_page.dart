import 'package:answer_five/core/utils/constants/string_constants.dart';
import 'package:answer_five/features/authentication/presentation/bloc/auth_state.dart';
import 'package:answer_five/features/statistic/presentation/pages/statistic_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/authentication/presentation/bloc/auth_bloc.dart';
import 'features/authentication/presentation/bloc/auth_event.dart';
import 'features/statistic/presentation/bloc/stats_bloc.dart';
import 'features/statistic/presentation/bloc/stats_event.dart';

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
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const StatisticPage(),
                ));
              },
              child: const Text('Statistics')),
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
