import 'package:answer_five/core/usecases/usecase.dart';
import 'package:answer_five/features/home/domain/usecases/get_player.dart';
import 'package:answer_five/features/home/domain/usecases/update_player_stats.dart';
import 'package:answer_five/features/home/presentation/bloc/home_event.dart';
import 'package:answer_five/features/home/presentation/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetPlayer _getPlayer;
  final UpdatePlayerStats _updatePlayerStats;

  HomeBloc(this._getPlayer, this._updatePlayerStats)
      : super(const HomeInitial()) {
    on<HomeStarted>(_onHomeStarted);
    on<HomePlayerStatsUpdated>(_onHomePlayerStatsUpdated);
  }

  Future<void> _onHomeStarted(
      HomeStarted event, Emitter<HomeState> emit) async {
    emit(const HomeLoading());
    final stream = await _getPlayer();
    return emit.forEach(
      stream,
      onData: (player) => HomeLoadSuccess(player),
      onError: (_, __) => const HomeLoadFailure("Something went wrong!"),
    );
  }

  Future<void> _onHomePlayerStatsUpdated(
      HomePlayerStatsUpdated event, Emitter<HomeState> emit) async {
    await _updatePlayerStats(
        UpdatePlayerStatsParams(event.statistic, event.isCorrect));
  }
}
