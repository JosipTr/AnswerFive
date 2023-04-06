import '../../domain/entities/trivia_result.dart';

class TriviaResultModel extends TriviaResult {
  const TriviaResultModel(
      {required super.category,
      required super.type,
      required super.difficulty,
      required super.question,
      required super.correctAnswer,
      required super.incorrectAnswers});

  factory TriviaResultModel.fromJson(Map<String, dynamic> json) {
    return TriviaResultModel(
      category: json['category'],
      type: json['type'],
      difficulty: json['difficulty'],
      question: json['question'],
      correctAnswer: json['correct_answer'],
      incorrectAnswers: List<String>.from(json['incorrect_answers']),
    );
  }
}
