import 'package:answer_five/core/utils/theme/custom_theme.dart';
import 'package:answer_five/features/home/presentation/bloc/home_bloc.dart';
import 'package:answer_five/features/home/presentation/bloc/home_state.dart';
import 'package:answer_five/features/statistic/presentation/widgets/statistic_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeState = context.read<HomeBloc>().state as HomeLoadSuccess;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Statistics",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: height * 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                              "Correct: ${homeState.player.statistic.correctAnswers}"),
                          Text(
                            "Incorrect: ${homeState.player.statistic.incorrectAnswers}",
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                              "Questions: ${homeState.player.statistic.totalQuestions}"),
                          homeState.player.statistic.totalQuestions != 0
                              ? Text(
                                  "WinRate: ${((homeState.player.statistic.correctAnswers / homeState.player.statistic.totalQuestions) * 100).toStringAsFixed(2)}%")
                              : const Text('WinRate: 0%')
                        ],
                      )
                    ],
                  ),
                ),
                Text(
                  'Rankings',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                StatisticWidget(homeState: homeState, height: height),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Back'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
