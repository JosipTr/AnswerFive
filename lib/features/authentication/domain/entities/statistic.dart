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

  Statistic copyWith(
      {int? totalQuestions, int? correctAnswers, int? incorrectAnswers}) {
    return Statistic(
        totalQuestions: totalQuestions ?? this.totalQuestions,
        correctAnswers: correctAnswers ?? this.correctAnswers,
        incorrectAnswers: incorrectAnswers ?? this.incorrectAnswers);
  }

  @override
  List<Object> get props => [totalQuestions, correctAnswers, incorrectAnswers];
}
