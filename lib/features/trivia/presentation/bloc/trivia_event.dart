import 'package:equatable/equatable.dart';

abstract class TriviaEvent extends Equatable {
  const TriviaEvent();

  @override
  List<Object?> get props => [];
}

class TriviaStarted extends TriviaEvent {
  const TriviaStarted();
}

class GetTriviaEvent extends TriviaEvent {
  const GetTriviaEvent();
}
