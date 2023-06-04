import 'package:answer_five/features/single_player/presentation/widgets/trivia_initial_widget.dart';
import 'package:answer_five/features/single_player/presentation/widgets/trivia_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/theme/custom_theme.dart';
import '../bloc/bloc.dart';

class SinglePlayerPage extends StatelessWidget {
  const SinglePlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    print('trivia page');
    return Scaffold(
      body: SingleChildScrollView(
        child: GradientBackground(
          child: Center(
            child: BlocConsumer<TriviaBloc, TriviaState>(
              listener: (context, state) {
                if (state is TriviaLoadFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.failureMessage)));
                }
              },
              builder: (context, state) {
                if (state is TriviaInitial) {
                  return const TriviaInitialWidget();
                } else if (state is TriviaLoadSuccess) {
                  return TriviaWidget(
                    state: state,
                  );
                } else if (state is TriviaLoading) {
                  return const CircularProgressIndicator();
                } else {
                  return const GradientBackground(child: Text(''));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
