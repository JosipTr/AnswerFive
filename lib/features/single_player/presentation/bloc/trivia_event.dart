import 'package:answer_five/features/single_player/presentation/bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/trivia.dart';

abstract class TriviaEvent extends Equatable {
  const TriviaEvent();
}

class TriviaStarted extends TriviaEvent {
  const TriviaStarted();

  @override
  List<Object?> get props => [];
}

class GetTriviaEvent extends TriviaEvent {
  const GetTriviaEvent();

  @override
  List<Object?> get props => [];
}

class TriviaBackButtonPressed extends TriviaEvent {
  const TriviaBackButtonPressed();

  @override
  List<Object?> get props => [];
}

class TriviaPageFiltered extends TriviaEvent {
  final Trivia trivia;
  final TriviaFilter filter;

  const TriviaPageFiltered(this.trivia, this.filter);

  @override
  List<Object?> get props => [trivia, filter];
}
