import '../../domain/entities/statistic.dart';

class StatisticModel extends Statistic {
  const StatisticModel(
      {super.correctAnswers,
      super.incorrectAnswers,
      super.totalQuestions,
      super.todayQuestionNumber});

  factory StatisticModel.fromJson(Map<dynamic, dynamic> json) {
    return StatisticModel(
      correctAnswers: json['correctAnswers'],
      incorrectAnswers: json['incorrectAnswers'],
      totalQuestions: json['totalQuestions'],
      todayQuestionNumber: json['todayQuestionNumber'],
    );
  }

  factory StatisticModel.fromStatistic(Statistic statistic) {
    return StatisticModel(
      correctAnswers: statistic.correctAnswers,
      incorrectAnswers: statistic.incorrectAnswers,
      totalQuestions: statistic.totalQuestions,
      todayQuestionNumber: statistic.todayQuestionNumber,
    );
  }

  Statistic toStatistic(StatisticModel statisticModel) {
    return Statistic(
      correctAnswers: statisticModel.correctAnswers,
      incorrectAnswers: statisticModel.incorrectAnswers,
      totalQuestions: statisticModel.totalQuestions,
      todayQuestionNumber: statisticModel.todayQuestionNumber,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'incorrectAnswers': incorrectAnswers,
      'todayQuestionNumber': todayQuestionNumber,
    };
  }
}
