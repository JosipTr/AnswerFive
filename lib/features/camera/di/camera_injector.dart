import 'package:answer_five/features/camera/data/datasources/camera_local_datasource.dart';
import 'package:answer_five/features/camera/domain/repositories/camera_repository.dart';
import 'package:answer_five/features/camera/presentation/bloc/camera_bloc.dart';
import 'package:camera/camera.dart';
import 'package:get_it/get_it.dart';

GetIt cameraInjector = GetIt.instance;
Future<void> initCameraDependencies() async {
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  cameraInjector.registerLazySingleton(() => firstCamera);

  cameraInjector.registerLazySingleton<CameraLocalDatasource>(
      () => CameraLocalDatasourceImpl(cameraInjector()));

  cameraInjector
      .registerLazySingleton(() => CameraRepository(cameraInjector()));

  cameraInjector.registerFactory(() => CameraBloc(cameraInjector()));
}
