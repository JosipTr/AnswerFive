import 'package:answer_five/core/locator.dart';
import 'package:answer_five/core/utils/theme/custom_theme.dart';
import 'package:answer_five/features/authentication/presentation/pages/auth_page.dart';
import 'package:answer_five/features/picker/presentation/bloc/picker_bloc.dart';
import 'package:answer_five/features/statistic/presentation/bloc/stats_event.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/authentication/presentation/bloc/auth_bloc.dart';
import 'features/authentication/presentation/bloc/auth_event.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/single_player/presentation/bloc/trivia_bloc.dart';
import 'features/statistic/presentation/bloc/stats_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  ServiceLocator.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => ServiceLocator.get()..add(AuthStarted()),
        ),
        BlocProvider<TriviaBloc>(
          create: (_) => ServiceLocator.get(),
        ),
        BlocProvider<StatsBloc>(
          create: (_) => ServiceLocator.get()..add(const Started()),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => ServiceLocator.get(),
        ),
        BlocProvider<PickerBloc>(
          create: (context) => ServiceLocator.get(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: getThemeData(),
        home: const AuthPage(),
      ),
    );
  }
}
