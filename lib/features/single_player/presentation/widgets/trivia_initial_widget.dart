import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constants/string_constants.dart';
import '../bloc/bloc.dart';

class TriviaInitialWidget extends StatelessWidget {
  const TriviaInitialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneHeight = MediaQuery.of(context).size.height;
    final double imageSize;
    if (phoneHeight < 800) {
      imageSize = 350;
    } else {
      imageSize = 400;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          StringConstants.logo,
          width: imageSize,
          height: imageSize,
        ),
        ElevatedButton(
          onPressed: () {
            context.read<TriviaBloc>().add(const GetTriviaEvent());
          },
          child: const Text('Get Trivia'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Back'),
        )
      ],
    );
  }
}
