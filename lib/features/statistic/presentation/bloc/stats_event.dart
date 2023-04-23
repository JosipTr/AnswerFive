import 'package:equatable/equatable.dart';

abstract class StatsEvent extends Equatable {
  const StatsEvent();
}

class Started extends StatsEvent {
  const Started();
  @override
  List<Object> get props => [];
}

class StatsUpdatePressed extends StatsEvent {
  final String id;
  final bool isCorrect;
  const StatsUpdatePressed(this.id, this.isCorrect);

  @override
  List<Object> get props => [id, isCorrect];
}

class StatsCreated extends StatsEvent {
  final String id;

  const StatsCreated(this.id);

  @override
  List<Object> get props => [id];
}
