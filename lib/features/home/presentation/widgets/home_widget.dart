import 'package:answer_five/features/single_player/presentation/pages/single_player_page.dart';
import 'package:answer_five/features/statistic/presentation/bloc/stats_bloc.dart';
import 'package:answer_five/features/statistic/presentation/bloc/stats_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constants/string_constants.dart';
import '../../../authentication/presentation/bloc/auth_bloc.dart';
import '../../../authentication/presentation/bloc/auth_event.dart';
import '../../../statistic/presentation/pages/statistic_page.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required this.imageSize,
  });

  final double imageSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          StringConstants.logo,
          width: imageSize,
          height: imageSize,
        ),
        Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SinglePlayerPage(),
                  ));
                },
                child: const Text('Single Player')),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  context.read<StatsBloc>().add(const Started());
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const StatisticPage(),
                  ));
                },
                child: const Text('Statistics')),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthLogoutPressed());
                },
                child: const Text('Logout')),
          ],
        ),
      ],
    );
  }
}
