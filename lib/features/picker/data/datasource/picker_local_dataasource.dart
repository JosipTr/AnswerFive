import 'dart:developer';

import 'package:image_picker/image_picker.dart';

import '../../../../core/errors/exceptions.dart';

abstract class PickerLocalDatasource {
  Future<XFile> getGalleryPicture();

  Future<XFile> getCameraPicture();
}

class PickerLocalDatasourceImpl implements PickerLocalDatasource {
  final ImagePicker _imagePicker;

  const PickerLocalDatasourceImpl(this._imagePicker);

  @override
  Future<XFile> getGalleryPicture() async {
    try {
      final xFile = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (xFile != null) {
        return xFile;
      } else {
        throw const PickerException();
      }
    } catch (error, stackTrace) {
      log(error: error, stackTrace: stackTrace, 'getGalleryPicture()');
      throw const PickerException();
    }
  }

  @override
  Future<XFile> getCameraPicture() async {
    try {
      final xFile = await _imagePicker.pickImage(source: ImageSource.camera);
      if (xFile != null) {
        return xFile;
      } else {
        throw const PickerException();
      }
    } catch (error, stackTrace) {
      log(error: error, stackTrace: stackTrace, 'getGalleryPicture()');
      throw const PickerException();
    }
  }
}
