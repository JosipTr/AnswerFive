import 'package:answer_five/core/errors/failures.dart';
import 'package:answer_five/core/usecases/usecase.dart';
import 'package:answer_five/features/picker/domain/repositories/picker_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

class GetCameraPicture implements UseCase<XFile?, NoParams> {
  final PickerRepository _repository;

  const GetCameraPicture(this._repository);

  @override
  Future<Either<Failure, XFile?>> call(NoParams params) async {
    return await _repository.getCameraPicture();
  }
}
