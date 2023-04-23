import 'package:answer_five/features/single_player/presentation/pages/single_player_page.dart';
import 'package:answer_five/features/statistic/presentation/bloc/stats_bloc.dart';
import 'package:answer_five/features/statistic/presentation/bloc/stats_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constants/string_constants.dart';
import '../../../authentication/presentation/bloc/auth_bloc.dart';
import '../../../authentication/presentation/bloc/auth_event.dart';
import '../../../statistic/presentation/pages/statistic_page.dart';
import '../../../statistic/presentation/widgets/statistic_widget.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required this.imageSize,
  });

  final double imageSize;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                builder: (context) => const SinglePlayerPage(),
              ));
            },
            child: const Text('Single Player')),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const StatisticPage(),
              ));
            },
            child: const Text('Statistics')),
        ElevatedButton(
            onPressed: () {
              context.read<StatsBloc>().add(Started());
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => StatisticWidget(),
              ));
            },
            child: const Text('Statistics')),
        ElevatedButton(
            onPressed: () {
              context.read<AuthBloc>().add(const AuthLogoutPressed());
            },
            child: const Text('Logout')),
      ],
    );
  }
}
