import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication/presentation/bloc/auth_bloc.dart';
import '../../../authentication/presentation/bloc/auth_event.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    log('home build');
    final phoneWidth = MediaQuery.of(context).size.width;
    final phoneHeight = MediaQuery.of(context).size.height;
    final appBarHeight = AppBar().preferredSize.height;
    final appBarWidth = AppBar().preferredSize.width;
    final safe = MediaQuery.of(context).padding.top;
    log(phoneHeight.toString());
    log(safe.toString());
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/answer_five_nobackground.png",
            width: 350,
            height: 350,
          ),
          ElevatedButton(onPressed: () {}, child: Text('Single Player')),
          ElevatedButton(onPressed: () {}, child: Text('Multi Player')),
          ElevatedButton(onPressed: () {}, child: Text('Settings')),
          ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(const AuthLogoutPressed());
              },
              child: Text('Logout')),
        ],
      ),
    );
  }
}
