import 'package:answer_five/core/utils/theme/custom_theme.dart';
import 'package:answer_five/features/home/presentation/bloc/home_bloc.dart';
import 'package:answer_five/features/home/presentation/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<HomeBloc>().state as HomeLoadSuccess;
    return Scaffold(
      body: GradientBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("CorrectAnswers: ${state.player.statistic.correctAnswers}"),
              Text(
                  "IncorrectAnswers: ${state.player.statistic.incorrectAnswers}"),
              Text("TotalQuestions: ${state.player.statistic.totalQuestions}"),
              Text(
                  "WinRate: ${((state.player.statistic.correctAnswers / state.player.statistic.totalQuestions) * 100).toStringAsFixed(2)}%")
            ],
          ),
        ),
      ),
    );
  }
}
