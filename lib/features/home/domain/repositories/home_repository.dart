import 'package:answer_five/features/authentication/domain/entities/player.dart';

abstract class HomeRepository {
  Stream<Player> getPlayer();
}
