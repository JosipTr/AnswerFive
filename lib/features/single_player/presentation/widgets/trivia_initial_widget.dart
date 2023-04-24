import 'package:answer_five/features/home/presentation/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/presentation/bloc/home_bloc.dart';
import '../bloc/bloc.dart';

class TriviaInitialWidget extends StatelessWidget {
  const TriviaInitialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final todayQuestionNumber =
        (context.read<HomeBloc>().state as HomeLoadSuccess)
            .player
            .statistic
            .todayQuestionNumber;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        todayQuestionNumber < 5
            ? Text(
                'Questions answered today:\n$todayQuestionNumber',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              )
            : const SizedBox(),
        todayQuestionNumber < 5
            ? ElevatedButton(
                onPressed: () {
                  context.read<TriviaBloc>().add(const GetTriviaEvent());
                },
                child: const Text('Start'),
              )
            : Text(
                "Already played today.\nCome back tomorrow.",
                style: Theme.of(context).textTheme.bodyLarge,
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
