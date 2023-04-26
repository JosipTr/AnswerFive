import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

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

class HomeImageUploaded extends HomeEvent {
  final XFile xFile;

  const HomeImageUploaded(this.xFile);

  @override
  List<Object> get props => [xFile];
}
