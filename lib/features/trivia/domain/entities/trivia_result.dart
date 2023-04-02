import 'package:equatable/equatable.dart';

class TriviaResult extends Equatable {
  final String category;
  final String type;
  final String difficulty;
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  const TriviaResult(
      {required this.category,
      required this.type,
      required this.difficulty,
      required this.question,
      required this.correctAnswer,
      required this.incorrectAnswers});

  @override
  List<Object> get props =>
      [category, difficulty, question, correctAnswer, incorrectAnswers];
}
