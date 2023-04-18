import 'package:answer_five/core/utils/theme/custom_theme.dart';
import 'package:answer_five/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:answer_five/features/authentication/presentation/bloc/auth_state.dart';
import 'package:answer_five/features/single_player/presentation/bloc/bloc.dart';
import 'package:answer_five/features/statistic/presentation/bloc/stats_bloc.dart';
import 'package:answer_five/features/statistic/presentation/bloc/stats_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SinglePlayerPage extends StatefulWidget {
  const SinglePlayerPage({super.key});

  @override
  State<SinglePlayerPage> createState() => _SinglePlayerPageState();
}

class _SinglePlayerPageState extends State<SinglePlayerPage> {
  var flag = 0;
  var isAnswered = false;
  @override
  Widget build(BuildContext context) {
    final playerId =
        (context.read<AuthBloc>().state as AuthLoadSuccess).user.id;
    return Scaffold(
      body: GradientBackground(
        child: Center(
          child: BlocBuilder<TriviaBloc, TriviaState>(
            builder: (context, state) {
              if (state is TriviaLoadSuccess) {
                if (flag < 6) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Image.asset(
                      //   "assets/images/answer_five_nobackground.png",
                      //   width: 350,
                      //   height: 350,
                      // ),
                      Container(
                        color: Colors.blue,
                        child: Text(state.trivia.question),
                      ),
                      for (var i = 0; i < state.trivia.answers.length; i++)
                        ElevatedButton(
                          onPressed: isAnswered
                              ? null
                              : () {
                                  if (state.trivia.answers[i] ==
                                      state.trivia.correctAnswer) {
                                    context.read<StatsBloc>().add(
                                        StatsUpdatePressed(playerId, true));
                                  } else {
                                    context.read<StatsBloc>().add(
                                        StatsUpdatePressed(playerId, false));
                                  }
                                  setState(() {
                                    isAnswered = true;
                                    flag = ++flag;
                                  });
                                },
                          style: ButtonStyle(
                              backgroundColor: isAnswered
                                  ? state.trivia.answers[i] !=
                                          state.trivia.correctAnswer
                                      ? MaterialStateColor.resolveWith(
                                          (states) => Colors.red)
                                      : MaterialStateColor.resolveWith(
                                          (states) => Colors.green)
                                  : null),
                          child: Text(state.trivia.answers[i]),
                        ),
                      isAnswered
                          ? ElevatedButton(
                              onPressed: () {
                                if (flag == 5) {
                                  context
                                      .read<TriviaBloc>()
                                      .add(const TriviaStarted());
                                } else {
                                  context
                                      .read<TriviaBloc>()
                                      .add(const GetTriviaEvent());
                                }
                                setState(() {
                                  isAnswered = false;
                                });
                              },
                              child: const Text('Next'))
                          : const SizedBox()
                    ],
                  );
                } else {
                  return ElevatedButton(
                      onPressed: () {
                        context.read<TriviaBloc>().add(const TriviaStarted());
                      },
                      child: const Text('No more'));
                }
              } else if (state is TriviaInitial) {
                return Column(
                  children: [
                    Image.asset(
                      "assets/images/answer_five_nobackground.png",
                      width: 350,
                      height: 350,
                    ),
                    ElevatedButton(
                        onPressed: () => context
                            .read<TriviaBloc>()
                            .add(const GetTriviaEvent()),
                        child: const Text('Get Trivia'))
                  ],
                );
              } else if (state is TriviaLoading) {
                return const CircularProgressIndicator();
              } else {
                return Image.asset(
                  "assets/images/answer_five_nobackground.png",
                  width: 350,
                  height: 350,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
