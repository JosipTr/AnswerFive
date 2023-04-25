import 'package:answer_five/core/usecases/usecase.dart';
import 'package:answer_five/features/picker/domain/usecases/get_gallery_picture.dart';
import 'package:answer_five/features/picker/presentation/bloc/picker_event.dart';
import 'package:answer_five/features/picker/presentation/bloc/picker_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickerBloc extends Bloc<PickerEvent, PickerState> {
  final GetGalleryPicture _getGalleryPicture;

  PickerBloc(this._getGalleryPicture) : super(const PickerInitial()) {
    on<PickerImagePicked>(_onPickerImagePicked);
  }

  Future<void> _onPickerImagePicked(
      PickerImagePicked event, Emitter<PickerState> emit) async {
    final either = await _getGalleryPicture(const NoParams());

    either.fold((l) => emit(PickerLoadFailure(l.message)),
        (r) => emit(PickerLoadSuccess(r)));
  }
}
