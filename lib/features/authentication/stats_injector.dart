import 'package:answer_five/features/authentication/auth_injector.dart';
import 'package:answer_five/features/authentication/data/datasources/stats_remote_data_source.dart';
import 'package:answer_five/features/authentication/data/repositories/stats_repository_impl.dart';
import 'package:answer_five/features/authentication/domain/repositories/stats_repository.dart';
import 'package:answer_five/features/authentication/domain/usecases/get_stats.dart';
import 'package:answer_five/features/authentication/domain/usecases/update_stats.dart';
import 'package:answer_five/features/authentication/presentation/bloc/stats_bloc/stats_bloc.dart';
import 'package:get_it/get_it.dart';

final statsInjector = GetIt.instance;

Future<void> initStatsDependencies() async {
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
