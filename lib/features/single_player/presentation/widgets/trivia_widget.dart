import 'package:answer_five/features/single_player/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TriviaWidget extends StatefulWidget {
  final TriviaLoadSuccess state;
  const TriviaWidget({super.key, required this.state});

  @override
  State<TriviaWidget> createState() => _TriviaWidgetState();
}

class _TriviaWidgetState extends State<TriviaWidget> {
  var isAnswered = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            widget.state.trivia.question,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          for (var i = 0; i < widget.state.trivia.answers.length; i++)
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
                      style: const TextStyle(fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  )
                : ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isAnswered = true;
                      });
                    },
                    child: Text(
                      widget.state.trivia.answers[i],
                      style: const TextStyle(fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
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
      ),
    );
  }
}
