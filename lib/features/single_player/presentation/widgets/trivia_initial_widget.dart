import 'package:answer_five/features/home/presentation/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constants/string_constants.dart';
import '../../../home/presentation/bloc/home_bloc.dart';
import '../bloc/bloc.dart';

class TriviaInitialWidget extends StatelessWidget {
  const TriviaInitialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final stats =
        (context.read<HomeBloc>().state as HomeLoadSuccess).player.statistic;
    final todayQuestionNumber =
        (context.read<HomeBloc>().state as HomeLoadSuccess)
            .player
            .statistic
            .todayQuestionNumber;
    final phoneHeight = MediaQuery.of(context).size.height;
    final double imageSize;
    if (phoneHeight < 800) {
      imageSize = 350;
    } else {
      imageSize = 400;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          StringConstants.logo,
          width: imageSize,
          height: imageSize,
        ),
        Text(
          'Questions answered today:\n${stats.todayQuestionNumber}',
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        todayQuestionNumber < 5
            ? ElevatedButton(
                onPressed: () {
                  context.read<TriviaBloc>().add(const GetTriviaEvent());
                },
                child: const Text('Get Trivia'),
              )
            : const Text(
                "Already played today.\nCome back tomorrow.",
                style: TextStyle(fontSize: 25),
              ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Back'),
        )
      ],
    );
  }
}
