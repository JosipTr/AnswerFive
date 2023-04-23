import 'package:equatable/equatable.dart';

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
