import 'package:answer_five/features/single_player/presentation/bloc/trivia_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../data/datasources/remote_data_source.dart';
import '../data/repositories/trivia_repository_impl.dart';
import '../domain/repositories/trivia_repository.dart';
import '../domain/usecases/get_trivia.dart';

final triviaInjector = GetIt.instance;

Future<void> initTriviaDependencies() async {
  triviaInjector.registerLazySingleton(() => http.Client());

  //Repository
  triviaInjector.registerLazySingleton<TriviaRepository>(
      () => TriviaRepositoryImpl(triviaInjector()));

  //UseCases
  triviaInjector.registerLazySingleton(() => GetTrivia(triviaInjector()));

  //Datasources
  triviaInjector.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(triviaInjector(), triviaInjector()));

  //Bloc
  triviaInjector.registerFactory(() => TriviaBloc(triviaInjector()));
}
