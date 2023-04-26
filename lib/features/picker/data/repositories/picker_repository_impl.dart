import 'package:answer_five/core/errors/failures.dart';
import 'package:answer_five/features/picker/data/datasource/picker_local_dataasource.dart';
import 'package:answer_five/features/picker/domain/repositories/picker_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/errors/exceptions.dart';

class PickerRepositoryImpl implements PickerRepository {
  final PickerLocalDatasource _pickerLocalDatasource;

  const PickerRepositoryImpl(this._pickerLocalDatasource);

  @override
  Future<Either<Failure, XFile?>> getGalleryPicture() async {
    try {
      final xFile = await _pickerLocalDatasource.getGalleryPicture();
      return Right(xFile);
    } on PickerException catch (error) {
      return Left(PickerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, XFile?>> getCameraPicture() async {
    try {
      final xFile = await _pickerLocalDatasource.getCameraPicture();
      return Right(xFile);
    } on PickerException catch (error) {
      return Left(PickerFailure(error.message));
    }
  }
}
