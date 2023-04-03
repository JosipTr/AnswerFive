import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import '../trivia/data/datasources/remote_data_source.dart';
import '../trivia/data/repositories/trivia_repository_impl.dart';
import '../trivia/domain/repositories/trivia_repository.dart';
import '../trivia/domain/usecases/get_trivia.dart';
import '../trivia/presentation/bloc/trivia_bloc.dart';

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
      () => RemoteDataSourceImpl(triviaInjector()));

  //Bloc
  triviaInjector.registerFactory(() => TriviaBloc(triviaInjector()));
}
