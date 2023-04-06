import 'package:equatable/equatable.dart';

import 'trivia_result.dart';

class Trivia extends Equatable {
  final int responseCode;
  final List<TriviaResult> results;

  const Trivia({required this.responseCode, required this.results});

  @override
  List<Object> get props => [responseCode, results];
}
