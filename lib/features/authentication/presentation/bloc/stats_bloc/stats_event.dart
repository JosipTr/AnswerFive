import 'package:equatable/equatable.dart';

import '../../../domain/entities/player.dart';
import '../../../domain/entities/statistic.dart';

abstract class StatsEvent extends Equatable {
  const StatsEvent();
}

class Started extends StatsEvent {
  final Player player;
  const Started(this.player);

  @override
  List<Object> get props => [player];
}

class StatsUpdatePressed extends StatsEvent {
  final Player player;
  const StatsUpdatePressed(this.player);

  @override
  List<Object> get props => [player];
}
