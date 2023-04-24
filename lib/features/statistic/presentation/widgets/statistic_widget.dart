import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/stats_bloc.dart';
import '../bloc/stats_state.dart';

class StatisticWidget extends StatelessWidget {
  const StatisticWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<StatsBloc, StatsState>(
          builder: (context, state) {
            if (state is StatsLoadSuccess) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var i = 0; i < state.players.length; i++)
                    Card(
                      elevation: 10,
                      child: ListTile(
                        leading:
                            CircleAvatar(child: Text(state.players[i].name)),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                                'Correct answers: ${state.players[i].statistic.correctAnswers}'
                                    .toString()),
                            Text(
                                'Points: ${state.players[i].statistic.correctAnswers * 3}'
                                    .toString()),
                          ],
                        ),
                      ),
                    )
                ],
              );
            } else {
              return const Text("no");
            }
          },
        ),
      ),
    );
  }
}
