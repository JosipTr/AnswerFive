import 'package:flutter/material.dart';

import '../bloc/trivia_state.dart';

class SinglePlayerPage extends StatelessWidget {
  final TriviaState state;
  const SinglePlayerPage({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
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
          child: Text(state.trivia!.results.first.question),
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text(state.trivia!.results.first.correctAnswer),
        ),
        for (final question in state.trivia!.results.first.incorrectAnswers)
          ElevatedButton(onPressed: () {}, child: Text(question)),
      ],
    );
  }
}
