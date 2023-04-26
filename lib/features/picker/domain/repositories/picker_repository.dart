import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/errors/failures.dart';

abstract class PickerRepository {
  Future<Either<Failure, XFile?>> getGalleryPicture();

  Future<Either<Failure, XFile?>> getCameraPicture();
}
