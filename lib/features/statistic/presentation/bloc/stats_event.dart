import 'package:equatable/equatable.dart';

abstract class StatsEvent extends Equatable {
  const StatsEvent();
}

class Started extends StatsEvent {
  final String id;
  const Started(this.id);

  @override
  List<Object> get props => [id];
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
