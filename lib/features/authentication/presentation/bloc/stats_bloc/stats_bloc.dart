import 'package:answer_five/core/usecases/usecase.dart';
import 'package:answer_five/features/authentication/domain/usecases/get_stats.dart';
import 'package:answer_five/features/authentication/domain/usecases/update_stats.dart';
import 'package:answer_five/features/authentication/presentation/bloc/stats_bloc/stats_event.dart';
import 'package:answer_five/features/authentication/presentation/bloc/stats_bloc/stats_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final GetStats _getStats;
  final UpdateStats _updateStats;
  StatsBloc(this._getStats, this._updateStats) : super(const StatsInitial()) {
    on<Started>(_onStarted);
    on<StatsUpdatePressed>(_onStatsUpdatePressed);
  }

  Future<void> _onStarted(Started event, Emitter<StatsState> emit) async {
    final either = await _getStats(StatsParams(event.player));
    either.fold((l) => emit(StatsLoadFailure(l.message)),
        (r) => emit(StatsLoadSuccess(r)));
  }

  Future<void> _onStatsUpdatePressed(
      StatsUpdatePressed event, Emitter<StatsState> emit) async {
    await _updateStats(StatsParams(event.player));
  }
}
