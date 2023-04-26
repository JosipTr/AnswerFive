import 'package:answer_five/features/home/presentation/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/theme/custom_theme.dart';
import '../bloc/stats_bloc.dart';
import '../bloc/stats_state.dart';

class StatisticWidget extends StatelessWidget {
  final HomeLoadSuccess homeState;
  final double height;
  const StatisticWidget({
    super.key,
    required this.homeState,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                      color: homeState.player.id == state.players[i].id
                          ? Colors.yellow.shade200
                          : Colors.white,
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${i + 1}.'),
                            SizedBox(
                              width: 70,
                              child: Text(
                                state.players[i].username,
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
            return const GradientBackground(child: Text('Empty rankings'));
          }
        },
      ),
    );
  }
}
