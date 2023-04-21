import 'package:answer_five/core/utils/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';
import '../widgets/home_initial_widget.dart';
import '../widgets/home_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneHeight = MediaQuery.of(context).size.height;
    final double imageSize;
    if (phoneHeight < 800) {
      imageSize = 350;
    } else {
      imageSize = 500;
    }
    return SingleChildScrollView(
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeLoadFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is HomeLoadSuccess) {
            return HomeWidget(imageSize: imageSize);
          } else if (state is HomeInitial) {
            return const HomeInitialWidget();
          } else {
            return const GradientBackground(child: Text(''));
          }
        },
      ),
    );
  }
}
