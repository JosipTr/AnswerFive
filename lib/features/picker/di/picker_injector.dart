import 'package:answer_five/features/picker/data/datasource/picker_local_dataasource.dart';
import 'package:answer_five/features/picker/data/repositories/picker_repository_impl.dart';
import 'package:answer_five/features/picker/domain/repositories/picker_repository.dart';
import 'package:answer_five/features/picker/domain/usecases/get_camera_picture.dart';
import 'package:answer_five/features/picker/domain/usecases/get_gallery_picture.dart';
import 'package:answer_five/features/picker/presentation/bloc/picker_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

GetIt pickerInjector = GetIt.instance;

Future<void> initPickerDependencies() async {
  final imagePicker = ImagePicker();

  pickerInjector.registerLazySingleton(() => imagePicker);

  pickerInjector.registerLazySingleton<PickerLocalDatasource>(
      () => PickerLocalDatasourceImpl(pickerInjector()));

  pickerInjector.registerLazySingleton<PickerRepository>(
      () => PickerRepositoryImpl(pickerInjector()));

  pickerInjector
      .registerLazySingleton(() => GetGalleryPicture(pickerInjector()));
  pickerInjector
      .registerLazySingleton(() => GetCameraPicture(pickerInjector()));

  pickerInjector
      .registerFactory(() => PickerBloc(pickerInjector(), pickerInjector()));
}
