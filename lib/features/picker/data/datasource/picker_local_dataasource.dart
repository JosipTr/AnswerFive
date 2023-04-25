import 'dart:developer';

import 'package:image_picker/image_picker.dart';

import '../../../../core/errors/exceptions.dart';

abstract class PickerLocalDatasource {
  Future<XFile?> getGalleryPicture();
}

class PickerLocalDatasourceImpl implements PickerLocalDatasource {
  final ImagePicker _imagePicker;

  const PickerLocalDatasourceImpl(this._imagePicker);

  @override
  Future<XFile?> getGalleryPicture() async {
    try {
      return await _imagePicker.pickImage(source: ImageSource.gallery);
    } catch (error, stackTrace) {
      log(error: error, stackTrace: stackTrace, 'getGalleryPicture()');
      throw const PickerException();
    }
  }
}
