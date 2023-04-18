import '../../domain/entities/player.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PlayerModel extends Player {
  const PlayerModel({
    required super.id,
    required super.name,
    required super.email,
  });

  factory PlayerModel.fromUser(User user) {
    return PlayerModel(
      id: user.uid,
      name: user.displayName ?? 'empty',
      email: user.email ?? 'empty',
    );
  }

  factory PlayerModel.fromPlayer(Player player) {
    return PlayerModel(
      id: player.id,
      name: player.name,
      email: player.email,
    );
  }

  factory PlayerModel.fromMap(Map<dynamic, dynamic> map) {
    return PlayerModel(id: map['id'], name: map['name'], email: map['email']);
  }

  Player toTriviaUser() {
    return Player(
      id: id,
      name: name,
      email: email,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
