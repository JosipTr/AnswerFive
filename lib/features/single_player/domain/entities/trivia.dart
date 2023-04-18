import 'package:equatable/equatable.dart';

class Trivia extends Equatable {
  final String category;
  final String type;
  final String difficulty;
  final String question;
  final List<String> answers;
  final String correctAnswer;

  const Trivia(
      {required this.category,
      required this.type,
      required this.difficulty,
      required this.question,
      required this.answers,
      required this.correctAnswer});

  @override
  List<Object> get props =>
      [category, difficulty, question, answers, correctAnswer];
  Trivia copyWith(
      {String? category,
      String? type,
      String? difficulty,
      String? question,
      List<String>? answers,
      String? correctAnswer}) {
    return Trivia(
        category: category ?? this.category,
        type: type ?? this.type,
        difficulty: difficulty ?? this.difficulty,
        question: question ?? this.question,
        answers: answers ?? this.answers,
        correctAnswer: correctAnswer ?? this.correctAnswer);
  }
}
