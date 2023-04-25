import 'package:answer_five/features/camera/data/datasources/camera_local_datasource.dart';
import 'package:answer_five/features/camera/data/repositories/camera_repository_impl.dart';
import 'package:answer_five/features/camera/domain/repositories/camera_repository.dart';
import 'package:answer_five/features/camera/domain/usecases/initialize_camera.dart';
import 'package:answer_five/features/camera/domain/usecases/take_picture.dart';
import 'package:answer_five/features/camera/presentation/bloc/camera_bloc.dart';
import 'package:camera/camera.dart';
import 'package:get_it/get_it.dart';

GetIt cameraInjector = GetIt.instance;
Future<void> initCameraDependencies() async {
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  final camera =
      CameraController(firstCamera, ResolutionPreset.max, enableAudio: false);

  //Camera
  cameraInjector.registerLazySingleton(() => camera);

  cameraInjector.registerLazySingleton<CameraLocalDatasource>(
      () => CameraLocalDatasourceImpl(cameraInjector()));

  cameraInjector.registerLazySingleton<CameraRepository>(
      () => CameraRepositoryImpl(cameraInjector()));

  cameraInjector
      .registerLazySingleton(() => InitializeCamera(cameraInjector()));

  cameraInjector.registerLazySingleton(() => TakePicture(cameraInjector()));

  cameraInjector
      .registerFactory(() => CameraBloc(cameraInjector(), cameraInjector()));
}
