import 'package:answer_five/features/home/data/datasources/home_remote_datasource.dart';
import 'package:answer_five/features/home/domain/usecases/get_player.dart';
import 'package:answer_five/features/home/domain/usecases/update_last_active.dart';
import 'package:answer_five/features/home/domain/usecases/update_player_stats.dart';
import 'package:answer_five/features/home/domain/usecases/upload_image.dart';

import 'package:get_it/get_it.dart';

import '../data/repositories/home_repository_impl.dart';
import '../domain/repositories/home_repository.dart';
import '../presentation/bloc/home_bloc.dart';

final homeInjector = GetIt.instance;

Future<void> initHomeDependencies() async {
  //Repositories
  homeInjector.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(homeInjector()));

  //Datasources
  homeInjector.registerLazySingleton<HomeRemoteDatasource>(() =>
      HomeRemoteDatasourceImpl(
          homeInjector(), homeInjector(), homeInjector(), homeInjector()));

  //Usecases
  homeInjector.registerLazySingleton(() => GetPlayer(homeInjector()));
  homeInjector.registerLazySingleton(() => UpdatePlayerStats(homeInjector()));
  homeInjector.registerLazySingleton(() => UpdateLastActive(homeInjector()));
  homeInjector.registerLazySingleton(() => UploadImage(homeInjector()));

  //Bloc
  homeInjector.registerFactory(() =>
      HomeBloc(homeInjector(), homeInjector(), homeInjector(), homeInjector()));
}
