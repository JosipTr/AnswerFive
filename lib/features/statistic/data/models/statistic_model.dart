import '../../domain/entities/statistic.dart';

class StatisticModel extends Statistic {
  const StatisticModel(
      {super.correctAnswers, super.incorrectAnswers, super.totalQuestions});

  factory StatisticModel.fromJson(Map<dynamic, dynamic> json) {
    return StatisticModel(
      correctAnswers: json['correctAnswers'],
      incorrectAnswers: json['incorrectAnswers'],
      totalQuestions: json['totalQuestions'],
    );
  }

  factory StatisticModel.fromStatistic(Statistic statistic) {
    return StatisticModel(
      correctAnswers: statistic.correctAnswers,
      incorrectAnswers: statistic.incorrectAnswers,
      totalQuestions: statistic.totalQuestions,
    );
  }

  Statistic toStatistic(StatisticModel statisticModel) {
    return Statistic(
      correctAnswers: statisticModel.correctAnswers,
      incorrectAnswers: statisticModel.incorrectAnswers,
      totalQuestions: statisticModel.totalQuestions,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'incorrectAnswers': incorrectAnswers,
    };
  }
}
