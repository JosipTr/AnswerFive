import 'package:equatable/equatable.dart';

import '../../../authentication/domain/entities/player.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();

  @override
  List<Object> get props => [];
}

class HomeLoadSuccess extends HomeState {
  final Player player;

  const HomeLoadSuccess(this.player);

  @override
  List<Object> get props => [player];
}

class HomeLoadFailure extends HomeState {
  final String message;

  const HomeLoadFailure(this.message);

  @override
  List<Object> get props => [message];
}

class HomeLoading extends HomeState {
  const HomeLoading();

  @override
  List<Object> get props => [];
}
