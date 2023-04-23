import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_trivia.dart';
import './bloc.dart';

class TriviaBloc extends Bloc<TriviaEvent, TriviaState> {
  final GetTrivia _getTrivia;

  TriviaBloc(this._getTrivia) : super(const TriviaInitial()) {
    on<GetTriviaEvent>(_onGetTriviaEvent);
    on<TriviaStarted>(_onTriviaStarted);
    on<TriviaBackButtonPressed>(_onTriviaBackButtonPressed);
  }

  void _onTriviaStarted(TriviaStarted event, Emitter<TriviaState> emit) async {
    emit(const TriviaInitial());
  }

  void _onGetTriviaEvent(
      GetTriviaEvent event, Emitter<TriviaState> emit) async {
    emit(const TriviaLoading());
    final either = await _getTrivia(const NoParams());
    either.fold((failure) {
      emit(TriviaLoadFailure(failure.message));
      emit(const TriviaInitial());
    }, (trivia) => emit(TriviaLoadSuccess(trivia)));
  }

  void _onTriviaBackButtonPressed(
      TriviaBackButtonPressed event, Emitter<TriviaState> emit) {
    emit(const TriviaLoading());
    emit(const TriviaInitial());
  }
}
