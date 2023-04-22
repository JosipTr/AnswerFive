import 'package:equatable/equatable.dart';

import '../../../statistic/domain/entities/statistic.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeStarted extends HomeEvent {
  const HomeStarted();

  @override
  List<Object> get props => [];
}

class HomePlayerStatsUpdated extends HomeEvent {
  final Statistic statistic;
  final bool isCorrect;

  const HomePlayerStatsUpdated(this.statistic, this.isCorrect);

  @override
  List<Object> get props => [statistic];
}
