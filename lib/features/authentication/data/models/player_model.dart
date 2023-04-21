import 'package:answer_five/features/statistic/data/models/statistic_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/player.dart';

class PlayerModel extends Player {
  const PlayerModel({
    required super.id,
    required super.name,
    required super.email,
    required super.statistic,
  });

  factory PlayerModel.fromUser(User user) {
    return PlayerModel(
        id: user.uid,
        name: user.displayName ?? 'empty',
        email: user.email ?? 'empty',
        statistic: const StatisticModel());
  }

  factory PlayerModel.fromPlayer(Player player) {
    return PlayerModel(
      id: player.id,
      name: player.name,
      email: player.email,
      statistic: player.statistic,
    );
  }

  factory PlayerModel.fromJson(Map<dynamic, dynamic> json) {
    return PlayerModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      statistic: StatisticModel.fromJson(json['statistic']),
    );
  }

  Player toPlayer() {
    return Player(
      id: id,
      name: name,
      email: email,
      statistic: statistic,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'statistic': (statistic as StatisticModel).toJson()
    };
  }
}
