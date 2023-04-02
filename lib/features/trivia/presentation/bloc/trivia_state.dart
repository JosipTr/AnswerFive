import 'package:equatable/equatable.dart';

import '../../domain/entities/trivia.dart';
import '../../domain/entities/trivia_result.dart';

enum TriviaStatus { initial, loading, success, failure }

class TriviaState extends Equatable {
  final Trivia? trivia;
  final TriviaStatus triviaStatus;
  const TriviaState({this.trivia, this.triviaStatus = TriviaStatus.initial});

  @override
  List<Object?> get props => [trivia, triviaStatus];
  TriviaState copyWith({Trivia? trivia, TriviaStatus? triviaStatus}) {
    return TriviaState(
        trivia: trivia ?? this.trivia,
        triviaStatus: triviaStatus ?? this.triviaStatus);
  }
}
