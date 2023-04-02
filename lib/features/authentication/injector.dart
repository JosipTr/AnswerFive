import 'package:answer_five/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:answer_five/features/authentication/domain/repositories/auth_repository.dart';
import 'package:answer_five/features/authentication/domain/usecases/auth_state_changes.dart';
import 'package:answer_five/features/authentication/domain/usecases/login_with_email_and_password.dart';
import 'package:answer_five/features/authentication/domain/usecases/logout.dart';
import 'package:answer_five/features/authentication/domain/usecases/register_user_with_email_and_password.dart';
import 'package:answer_five/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import '../trivia/data/datasources/remote_data_source.dart';
import '../trivia/data/repositories/trivia_repository_impl.dart';
import '../trivia/domain/repositories/trivia_repository.dart';
import '../trivia/domain/usecases/get_trivia.dart';
import '../trivia/presentation/bloc/trivia_bloc.dart';
import 'data/repositories/auth_repository_impl.dart';

final di = GetIt.instance;

Future<void> initDependencies() async {
  final firebaseAuth = FirebaseAuth.instance;

  //FirebaseAuth
  di.registerLazySingleton(() => firebaseAuth);

  //Repositories
  di.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(di()));

  //Datasources
  di.registerLazySingleton<AuthLocalDatasource>(
      () => AuthenticationLocalDatasourceImpl(di()));

  //UseCases
  di.registerLazySingleton(() => Logout(di()));
  di.registerLazySingleton(() => AuthStateChanges(di()));
  di.registerLazySingleton(() => RegisterUserWithEmailAndPassword(di()));
  di.registerLazySingleton(() => LoginWithEmailAndPassword(di()));

  //Bloc
  di.registerFactory(() => AuthBloc(di(), di(), di(), di()));

  di.registerLazySingleton(() => http.Client());

  //Repository
  di.registerLazySingleton<TriviaRepository>(() => TriviaRepositoryImpl(di()));

  //UseCases
  di.registerLazySingleton(() => GetTrivia(di()));

  //Datasources
  di.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(di()));

  //Bloc
  di.registerFactory(() => TriviaBloc(di()));
}
