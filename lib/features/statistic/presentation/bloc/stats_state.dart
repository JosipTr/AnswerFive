import 'package:equatable/equatable.dart';

import '../../../authentication/domain/entities/player.dart';
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
  final List<Player> players;
  const StatsLoadSuccess(this.players);

  @override
  List<Object> get props => [players];
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
