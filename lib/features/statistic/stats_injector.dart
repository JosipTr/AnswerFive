import 'package:answer_five/features/authentication/di/auth_injector.dart';
import 'package:answer_five/features/statistic/data/datasources/stats_remote_data_source.dart';
import 'package:answer_five/features/statistic/data/repositories/stats_repository_impl.dart';
import 'package:answer_five/features/statistic/domain/repositories/stats_repository.dart';
import 'package:answer_five/features/statistic/presentation/bloc/stats_bloc.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:get_it/get_it.dart';

import 'domain/usecases/get_stats.dart';
import 'domain/usecases/update_stats.dart';

final statsInjector = GetIt.instance;

Future<void> initStatsDependencies() async {
  //FirebaseDatabase
  authInjector.registerLazySingleton(() => FirebaseDatabase.instance);

  //Repositories
  statsInjector.registerLazySingleton<StatsRepository>(
      () => StatsRepositoryImpl(statsInjector()));

  //Datasources
  statsInjector.registerLazySingleton<StatsRemoteDataSource>(
      () => StatsRemoteDataSourceImpl(statsInjector(), authInjector()));

  //Usecases
  statsInjector.registerLazySingleton(() => GetStats(statsInjector()));
  statsInjector.registerLazySingleton(() => UpdateStats(statsInjector()));

  //Bloc
  statsInjector
      .registerFactory(() => StatsBloc(statsInjector(), statsInjector()));
}
