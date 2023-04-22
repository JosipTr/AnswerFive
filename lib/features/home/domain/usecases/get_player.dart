import 'package:answer_five/features/authentication/domain/entities/player.dart';
import 'package:answer_five/features/home/domain/repositories/home_repository.dart';

class GetPlayer {
  final HomeRepository _homeRepository;

  const GetPlayer(this._homeRepository);

  Future<Stream<Player>> call() async {
    await _homeRepository.updateTodayQuestionNumber();
    await _homeRepository.updateLastActive((DateTime.now().toString()));
    return _homeRepository.getPlayer();
  }
}
