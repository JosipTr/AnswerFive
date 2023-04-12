import 'package:equatable/equatable.dart';

import '../../domain/entities/trivia.dart';

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
  final Trivia trivia;
  const TriviaLoadSuccess(this.trivia);

  @override
  List<Object> get props => [trivia];
}

class TriviaLoadFailure extends TriviaState {
  final String failureMessage;
  const TriviaLoadFailure(this.failureMessage);

  @override
  List<Object> get props => [failureMessage];
}
