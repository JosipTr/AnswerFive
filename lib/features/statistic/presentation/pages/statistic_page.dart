import 'package:answer_five/core/utils/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/stats_bloc.dart';
import '../bloc/stats_state.dart';
import '../widgets/statistic_widget.dart';

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
                return const StatsticWidget();
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
