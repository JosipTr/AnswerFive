import 'package:answer_five/features/authentication/di/auth_injector.dart';
import 'package:answer_five/features/single_player/di/trivia_injector.dart';
import 'package:get_it/get_it.dart';

import '../features/camera/di/camera_injector.dart';
import '../features/home/di/home_injector.dart';
import '../features/statistic/stats_injector.dart';

class ServiceLocator {
  static final _getIt = GetIt.instance;

  static void setup() {
    initAuthDependencies();
    initTriviaDependencies();
    initStatsDependencies();
    initHomeDependencies();
    initCameraDependencies();
  }

  static T get<T extends Object>() {
    return _getIt.get<T>();
  }
}
