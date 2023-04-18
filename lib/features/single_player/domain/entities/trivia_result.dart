import 'package:equatable/equatable.dart';

class TriviaResult extends Equatable {
  final String category;
  final String type;
  final String difficulty;
  final String question;
  final List<String> answers;
  final String correctAnswer;

  const TriviaResult(
      {required this.category,
      required this.type,
      required this.difficulty,
      required this.question,
      required this.answers,
      required this.correctAnswer});

  @override
  List<Object> get props =>
      [category, difficulty, question, answers, correctAnswer];
}
