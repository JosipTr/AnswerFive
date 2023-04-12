import 'package:equatable/equatable.dart';

class Statistic extends Equatable {
  final int totalQuestions;
  final int correctAnswers;
  final int incorrectAnswers;

  const Statistic({
    this.totalQuestions = 0,
    this.correctAnswers = 0,
    this.incorrectAnswers = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'incorrectAnswers': incorrectAnswers,
    };
  }

  @override
  List<Object> get props => [totalQuestions, correctAnswers, incorrectAnswers];
}
