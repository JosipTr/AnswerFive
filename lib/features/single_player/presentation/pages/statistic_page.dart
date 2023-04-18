import 'package:answer_five/core/utils/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../statistic/presentation/bloc/stats_bloc.dart';
import '../../../statistic/presentation/bloc/stats_state.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Center(
          child: BlocBuilder<StatsBloc, StatsState>(
            builder: (context, state) {
              if (state is StatsLoadSuccess) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("CorrectAnswers: ${state.statistic.correctAnswers}"),
                    Text(
                        "IncorrectAnswers: ${state.statistic.incorrectAnswers}"),
                    Text("TotalQuestions: ${state.statistic.totalQuestions}"),
                  ],
                );
              } else if (state is StatsLoadFailure) {
                return Text(state.message);
              } else if (state is StatsLoading) {
                return const CircularProgressIndicator();
              }
              return const Text('blabla');
            },
          ),
        ),
      ),
    );
  }
}
