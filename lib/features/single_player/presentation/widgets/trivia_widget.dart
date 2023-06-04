import 'package:answer_five/features/home/presentation/bloc/home_bloc.dart';
import 'package:answer_five/features/home/presentation/bloc/home_event.dart';
import 'package:answer_five/features/home/presentation/bloc/home_state.dart';
import 'package:answer_five/features/single_player/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TriviaWidget extends StatelessWidget {
  final TriviaLoadSuccess state;
  const TriviaWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<TriviaBloc>().add(const TriviaBackButtonPressed());
        return false;
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              state.trivia.question,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            BlocBuilder<TriviaBloc, TriviaState>(
              builder: (context, state) => state is TriviaLoadSuccess &&
                      state.triviaFilter == TriviaFilter.answered
                  ? _TriviaAnswered(
                      state: state,
                    )
                  : _TriviaAnswers(state: state as TriviaLoadSuccess),
            )
          ],
        ),
      ),
    );
  }
}

class _TriviaAnswered extends StatelessWidget {
  final TriviaLoadSuccess state;
  const _TriviaAnswered({required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < state.trivia.answers.length; i++)
          Column(
            children: [
              ElevatedButton(
                onPressed: null,
                style: ButtonStyle(
                    backgroundColor:
                        state.trivia.answers[i] == state.trivia.correctAnswer
                            ? MaterialStateColor.resolveWith(
                                (states) => Colors.green)
                            : MaterialStateColor.resolveWith(
                                (states) => Colors.red)),
                child: Text(
                  state.trivia.answers[i],
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 35),
            ],
          ),
        ElevatedButton(
          onPressed: () {
            context.read<TriviaBloc>().add(const GetTriviaEvent());
          },
          child: const Text('Next Question'),
        )
      ],
    );
  }
}

class _TriviaAnswers extends StatelessWidget {
  final TriviaLoadSuccess state;
  const _TriviaAnswers({required this.state});

  @override
  Widget build(BuildContext context) {
    final stats =
        (context.read<HomeBloc>().state as HomeLoadSuccess).player.statistic;
    return Column(
      children: [
        for (var i = 0; i < state.trivia.answers.length; i++)
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  if (state.trivia.answers[i] == state.trivia.correctAnswer) {
                    context
                        .read<HomeBloc>()
                        .add(HomePlayerStatsUpdated(stats, true));
                  } else {
                    context
                        .read<HomeBloc>()
                        .add(HomePlayerStatsUpdated(stats, false));
                  }
                  context.read<TriviaBloc>().add(
                      TriviaPageFiltered(state.trivia, TriviaFilter.answered));
                },
                child: Text(
                  state.trivia.answers[i],
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 35),
            ],
          ),
      ],
    );
  }
}
