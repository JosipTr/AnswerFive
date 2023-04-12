import '../../domain/entities/statistic.dart';

class StatisticModel extends Statistic {
  const StatisticModel(
      {super.correctAnswers, super.incorrectAnswers, super.totalQuestions});

  Map<String, dynamic> toJson() {
    return {
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'incorrectAnswers': incorrectAnswers,
    };
  }
}
