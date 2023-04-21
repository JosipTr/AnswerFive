import 'package:answer_five/features/authentication/domain/entities/player.dart';
import 'package:answer_five/features/home/domain/repositories/home_repository.dart';

class GetPlayer {
  final HomeRepository _homeRepository;

  const GetPlayer(this._homeRepository);

  Stream<Player> call() {
    return _homeRepository.getPlayer();
  }
}
