import 'package:answer_five/features/authentication/di/auth_injector.dart';
import 'package:answer_five/features/picker/di/picker_injector.dart';
import 'package:answer_five/features/single_player/di/trivia_injector.dart';
import 'package:get_it/get_it.dart';

import '../features/home/di/home_injector.dart';
import '../features/statistic/stats_injector.dart';

class ServiceLocator {
  static final _getIt = GetIt.instance;

  static void setup() {
    initAuthDependencies();
    initTriviaDependencies();
    initStatsDependencies();
    initHomeDependencies();
    initPickerDependencies();
  }

  static T get<T extends Object>() {
    return _getIt.get<T>();
  }
}
