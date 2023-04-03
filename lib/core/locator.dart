import 'package:answer_five/features/authentication/auth_injector.dart';
import 'package:answer_five/features/trivia/trivia_injector.dart';
import 'package:get_it/get_it.dart';

class ServiceLocator {
  static final _getIt = GetIt.instance;

  static void setup() {
    initAuthDependencies();
    initTriviaDependencies();
  }

  static T get<T extends Object>() {
    return _getIt.get<T>();
  }
}
