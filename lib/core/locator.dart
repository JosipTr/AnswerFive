import 'package:answer_five/features/authentication/auth_injector.dart';
import 'package:answer_five/features/single_player/trivia_injector.dart';
import 'package:get_it/get_it.dart';

import '../features/authentication/stats_injector.dart';

class ServiceLocator {
  static final _getIt = GetIt.instance;

  static void setup() {
    initAuthDependencies();
    initTriviaDependencies();
    initStatsDependencies();
  }

  static T get<T extends Object>() {
    return _getIt.get<T>();
  }
}
