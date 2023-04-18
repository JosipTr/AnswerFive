import '../../domain/entities/trivia_result.dart';

class TriviaResultModel extends TriviaResult {
  const TriviaResultModel(
      {required super.category,
      required super.type,
      required super.difficulty,
      required super.question,
      required super.answers,
      required super.correctAnswer});

  factory TriviaResultModel.fromJson(Map<String, dynamic> json) {
    List<String> answers = List<String>.from(json['incorrect_answers']);
    answers.add(json['correct_answer']);
    answers.shuffle();

    return TriviaResultModel(
        category: json['category'],
        type: json['type'],
        difficulty: json['difficulty'],
        question: json['question'],
        correctAnswer: json['correct_answer'],
        answers: answers);
  }
}
