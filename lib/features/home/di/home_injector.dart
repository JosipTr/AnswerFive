import 'package:answer_five/features/home/data/datasources/home_remote_datasource.dart';
import 'package:answer_five/features/home/domain/usecases/get_player.dart';
import 'package:get_it/get_it.dart';

import '../data/repositories/home_repository_impl.dart';
import '../domain/repositories/home_repository.dart';
import '../presentation/bloc/home_bloc.dart';

final homeInjector = GetIt.instance;

Future<void> initHomeDependencies() async {
  // //FirebaseDatabase
  // homeInjector.registerLazySingleton(() => FirebaseDatabase.instance);

  //Repositories
  homeInjector.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(homeInjector()));

  //Datasources
  homeInjector.registerLazySingleton<HomeRemoteDatasource>(
      () => HomeRemoteDatasourceImpl(homeInjector(), homeInjector()));

  //Usecases
  homeInjector.registerLazySingleton(() => GetPlayer(homeInjector()));

  //Bloc
  homeInjector.registerFactory(() => HomeBloc(homeInjector()));
}
