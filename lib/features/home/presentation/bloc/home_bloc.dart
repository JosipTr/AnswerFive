import 'package:answer_five/features/home/domain/usecases/get_player.dart';
import 'package:answer_five/features/home/presentation/bloc/home_event.dart';
import 'package:answer_five/features/home/presentation/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetPlayer _getPlayer;

  HomeBloc(this._getPlayer) : super(const HomeInitial()) {
    on<HomeStarted>(
      (event, emit) {
        emit(const HomeLoading());
        final stream = _getPlayer();
        return emit.forEach(
          stream,
          onData: (player) => HomeLoadSuccess(player),
          onError: (_, __) => const HomeLoadFailure("Something went wrong!"),
        );
      },
    );
  }
}
