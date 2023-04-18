import 'package:equatable/equatable.dart';

import '../../domain/entities/statistic.dart';

abstract class StatsState extends Equatable {
  const StatsState();
}

class StatsInitial extends StatsState {
  const StatsInitial();

  @override
  List<Object> get props => [];
}

class StatsLoadSuccess extends StatsState {
  final Statistic statistic;
  const StatsLoadSuccess(this.statistic);

  @override
  List<Object> get props => [statistic];
}

class StatsLoadFailure extends StatsState {
  final String message;
  const StatsLoadFailure(this.message);

  @override
  List<Object> get props => [message];
}

class StatsLoading extends StatsState {
  const StatsLoading();

  @override
  List<Object> get props => [];
}
