import 'package:equatable/equatable.dart';

import '../../domain/entities/trivia.dart';

enum TriviaFilter { initial, answered }

abstract class TriviaState extends Equatable {
  const TriviaState();
}

class TriviaInitial extends TriviaState {
  const TriviaInitial();

  @override
  List<Object> get props => [];
}

class TriviaLoading extends TriviaState {
  const TriviaLoading();

  @override
  List<Object> get props => [];
}

class TriviaLoadSuccess extends TriviaState {
  final TriviaFilter triviaFilter;
  final Trivia trivia;
  const TriviaLoadSuccess(this.trivia, this.triviaFilter);

  @override
  List<Object> get props => [trivia, triviaFilter];
}

class TriviaLoadFailure extends TriviaState {
  final String failureMessage;
  const TriviaLoadFailure(this.failureMessage);

  @override
  List<Object> get props => [failureMessage];
}
