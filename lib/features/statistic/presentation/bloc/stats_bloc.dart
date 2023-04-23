import 'package:answer_five/core/usecases/usecase.dart';
import 'package:answer_five/features/statistic/presentation/bloc/stats_event.dart';
import 'package:answer_five/features/statistic/presentation/bloc/stats_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_stats.dart';
import '../../domain/usecases/update_stats.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final GetStats _getStats;
  final UpdateStats _updateStats;
  StatsBloc(
    this._getStats,
    this._updateStats,
  ) : super(const StatsInitial()) {
    on<Started>(_onStarted);
    on<StatsUpdatePressed>(_onStatsUpdatePressed);
  }

  Future<void> _onStarted(Started event, Emitter<StatsState> emit) async {
    emit(const StatsLoading());
    final either = await _getStats(const NoParams());
    either.fold((l) => emit(StatsLoadFailure(l.message)),
        (r) => emit(StatsLoadSuccess(r)));
  }

  Future<void> _onStatsUpdatePressed(
      StatsUpdatePressed event, Emitter<StatsState> emit) async {
    await _updateStats(StatsParams(event.id, isCorrect: event.isCorrect));
  }
}
