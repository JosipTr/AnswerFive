import 'package:answer_five/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:answer_five/features/authentication/domain/repositories/auth_repository.dart';
import 'package:answer_five/features/authentication/domain/usecases/auth_state_changes.dart';
import 'package:answer_five/features/authentication/domain/usecases/login_with_email_and_password.dart';
import 'package:answer_five/features/authentication/domain/usecases/logout.dart';
import 'package:answer_five/features/authentication/domain/usecases/register_user_with_email_and_password.dart';
import 'package:answer_five/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'data/repositories/auth_repository_impl.dart';

final authInjector = GetIt.instance;

Future<void> initAuthDependencies() async {
  final firebaseAuth = FirebaseAuth.instance;

  //FirebaseAuth
  authInjector.registerLazySingleton(() => firebaseAuth);

  //Repositories
  authInjector.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authInjector()));

  //Datasources
  authInjector.registerLazySingleton<AuthLocalDatasource>(
      () => AuthenticationLocalDatasourceImpl(authInjector()));

  //UseCases
  authInjector.registerLazySingleton(() => Logout(authInjector()));
  authInjector.registerLazySingleton(() => AuthStateChanges(authInjector()));
  authInjector.registerLazySingleton(
      () => RegisterUserWithEmailAndPassword(authInjector()));
  authInjector
      .registerLazySingleton(() => LoginWithEmailAndPassword(authInjector()));

  //Bloc
  authInjector.registerFactory(() =>
      AuthBloc(authInjector(), authInjector(), authInjector(), authInjector()));
}
