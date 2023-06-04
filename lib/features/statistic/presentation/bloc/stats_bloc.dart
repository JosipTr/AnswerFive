import 'package:answer_five/core/usecases/usecase.dart';
import 'package:answer_five/features/statistic/presentation/bloc/stats_event.dart';
import 'package:answer_five/features/statistic/presentation/bloc/stats_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_stats.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final GetStats _getStats;
  StatsBloc(
    this._getStats,
  ) : super(const StatsInitial()) {
    on<Started>(_onStarted);
  }

  Future<void> _onStarted(Started event, Emitter<StatsState> emit) async {
    emit(const StatsLoading());
    final either = await _getStats(const NoParams());
    either.fold((l) => emit(StatsLoadFailure(l.message)),
        (r) => emit(StatsLoadSuccess(r)));
  }
}
