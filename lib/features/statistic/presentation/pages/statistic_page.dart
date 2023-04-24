import 'package:answer_five/core/utils/theme/custom_theme.dart';
import 'package:answer_five/features/home/presentation/bloc/home_bloc.dart';
import 'package:answer_five/features/home/presentation/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/stats_bloc.dart';
import '../bloc/stats_state.dart';

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
              mainAxisAlignment: MainAxisAlignment.start,
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
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: height * 0.3,
                  child: BlocBuilder<StatsBloc, StatsState>(
                    builder: (context, state) {
                      if (state is StatsLoadSuccess) {
                        return SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              for (var i = 0; i < state.players.length; i++)
                                Card(
                                  color:
                                      homeState.player.id == state.players[i].id
                                          ? Colors.yellow.shade200
                                          : Colors.white,
                                  child: ListTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('${i + 1}.'),
                                        SizedBox(
                                          width: 70,
                                          child: Text(
                                            state.players[i].name,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Text(
                                          'Questions:\n${state.players[i].statistic.totalQuestions}'
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          'Points:\n${state.players[i].statistic.correctAnswers * 3}'
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      } else if (state is StatsLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return const GradientBackground(
                            child: Text('Empty rankings'));
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
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
