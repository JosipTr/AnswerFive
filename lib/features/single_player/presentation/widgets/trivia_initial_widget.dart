import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';

class TriviaInitialWidget extends StatelessWidget {
  const TriviaInitialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            context.read<TriviaBloc>().add(const GetTriviaEvent());
          },
          child: const Text('Get Trivia'),
        )
      ],
    );
  }
}
