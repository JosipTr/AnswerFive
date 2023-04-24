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
            TriviaAnswers(state: state)
          ],
        ),
      ),
    );
  }
}

class TriviaAnswers extends StatefulWidget {
  final TriviaLoadSuccess state;
  const TriviaAnswers({super.key, required this.state});

  @override
  State<TriviaAnswers> createState() => _TriviaAnswersState();
}

class _TriviaAnswersState extends State<TriviaAnswers> {
  var isAnswered = false;
  @override
  Widget build(BuildContext context) {
    final stats =
        (context.read<HomeBloc>().state as HomeLoadSuccess).player.statistic;
    return Column(
      children: [
        for (var i = 0; i < widget.state.trivia.answers.length; i++)
          Column(
            children: [
              isAnswered
                  ? ElevatedButton(
                      onPressed: null,
                      style: ButtonStyle(
                          backgroundColor: widget.state.trivia.answers[i] ==
                                  widget.state.trivia.correctAnswer
                              ? MaterialStateColor.resolveWith(
                                  (states) => Colors.green)
                              : MaterialStateColor.resolveWith(
                                  (states) => Colors.red)),
                      child: Text(
                        widget.state.trivia.answers[i],
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        if (widget.state.trivia.answers[i] ==
                            widget.state.trivia.correctAnswer) {
                          context
                              .read<HomeBloc>()
                              .add(HomePlayerStatsUpdated(stats, true));
                        } else {
                          context
                              .read<HomeBloc>()
                              .add(HomePlayerStatsUpdated(stats, false));
                        }
                        setState(() {
                          isAnswered = true;
                        });
                      },
                      child: Text(
                        widget.state.trivia.answers[i],
                        textAlign: TextAlign.center,
                      ),
                    ),
              const SizedBox(height: 35),
            ],
          ),
        isAnswered
            ? ElevatedButton(
                onPressed: () {
                  context.read<TriviaBloc>().add(const GetTriviaEvent());
                },
                child: const Text('Next Question'),
              )
            : const SizedBox()
      ],
    );
  }
}
