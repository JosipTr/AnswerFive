import 'package:equatable/equatable.dart';

import '../../../domain/entities/player.dart';
import '../../../domain/entities/statistic.dart';

abstract class StatsState extends Equatable {
  const StatsState();
}

class StatsInitial extends StatsState {
  const StatsInitial();

  @override
  List<Object> get props => [];
}

class StatsLoadSuccess extends StatsState {
  final Player player;
  const StatsLoadSuccess(this.player);

  @override
  List<Object> get props => [player];
}

class StatsLoadFailure extends StatsState {
  final String message;
  const StatsLoadFailure(this.message);

  @override
  List<Object> get props => [message];
}
