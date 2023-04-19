import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/stats_bloc.dart';
import '../bloc/stats_state.dart';

class StatsticWidget extends StatelessWidget {
  const StatsticWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.read<StatsBloc>().state as StatsLoadSuccess;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text("CorrectAnswers: ${state.statistic.correctAnswers}"),
        Text("IncorrectAnswers: ${state.statistic.incorrectAnswers}"),
        Text("TotalQuestions: ${state.statistic.totalQuestions}"),
        Text(
            "WinRate: ${((state.statistic.correctAnswers / state.statistic.totalQuestions) * 100).toStringAsFixed(2)}%")
      ],
    );
  }
}
