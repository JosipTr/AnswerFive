import 'package:answer_five/core/utils/theme/custom_theme.dart';
import 'package:answer_five/features/single_player/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SinglePlayerPage extends StatefulWidget {
  const SinglePlayerPage({super.key});

  @override
  State<SinglePlayerPage> createState() => _SinglePlayerPageState();
}

class _SinglePlayerPageState extends State<SinglePlayerPage> {
  bool isCorrect = false;
  int flag = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Center(
          child: BlocBuilder<TriviaBloc, TriviaState>(
            builder: (context, state) {
              if (state is TriviaLoadSuccess) {
                if (flag <= 4) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/images/answer_five_nobackground.png",
                        width: 350,
                        height: 350,
                      ),
                      Container(
                        color: Colors.blue,
                        child: Text(state.trivia.results.first.question),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: isCorrect
                                ? MaterialStateColor.resolveWith(
                                    (states) => Colors.green)
                                : null),
                        onPressed: () {
                          setState(() {
                            isCorrect = true;
                          });
                        },
                        child: Text(state.trivia.results.first.correctAnswer),
                      ),
                      for (final question
                          in state.trivia.results.first.incorrectAnswers)
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isCorrect = true;
                            });
                          },
                          style: ButtonStyle(
                              backgroundColor: isCorrect
                                  ? MaterialStateColor.resolveWith(
                                      (states) => Colors.red)
                                  : null),
                          child: Text(question),
                        ),
                      isCorrect
                          ? ElevatedButton(
                              onPressed: () {
                                if (flag <= 4) {
                                  context
                                      .read<TriviaBloc>()
                                      .add(GetTriviaEvent());
                                  isCorrect = false;
                                  flag++;
                                } else {
                                  return;
                                }
                              },
                              child: const Text('Next'))
                          : SizedBox()
                    ],
                  );
                } else {
                  return ElevatedButton(
                      onPressed: () {
                        context.read<TriviaBloc>().add(TriviaStarted());
                      },
                      child: Text('No more'));
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
