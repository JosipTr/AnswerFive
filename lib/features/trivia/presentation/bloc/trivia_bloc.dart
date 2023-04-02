import 'package:answer_five/features/trivia/domain/entities/trivia.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/usecases/usecase.dart';
import '../../domain/usecases/get_trivia.dart';
import './bloc.dart';

class TriviaBloc extends Bloc<TriviaEvent, TriviaState> {
  final GetTrivia _getTrivia;

  TriviaBloc(this._getTrivia) : super(const TriviaState()) {
    on<GetTriviaEvent>(_onGetTriviaEvent);
    on<TriviaStarted>(_onTriviaStarted);
  }

  void _onTriviaStarted(TriviaStarted event, Emitter<TriviaState> emit) async {
    emit(state.copyWith(triviaStatus: TriviaStatus.initial));
  }

  void _onGetTriviaEvent(
      GetTriviaEvent event, Emitter<TriviaState> emit) async {
    final either = await _getTrivia(params: const NoParams());
    either.fold(
        (failure) => emit(state.copyWith(triviaStatus: TriviaStatus.failure)),
        (trivia) => emit(state.copyWith(
            trivia: trivia, triviaStatus: TriviaStatus.success)));
  }
}
