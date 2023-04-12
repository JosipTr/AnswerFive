import 'package:answer_five/features/single_player/domain/entities/statistic.dart';

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
