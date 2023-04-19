import 'package:answer_five/features/statistic/data/models/statistic_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/player.dart';

class PlayerModel extends Player {
  const PlayerModel({
    required super.id,
    required super.name,
    required super.email,
    required super.emailVerified,
    required super.statistic,
  });

  factory PlayerModel.fromUser(User user) {
    return PlayerModel(
        id: user.uid,
        name: user.displayName ?? 'empty',
        email: user.email ?? 'empty',
        emailVerified: user.emailVerified,
        statistic: const StatisticModel());
  }

  factory PlayerModel.fromPlayer(Player player) {
    return PlayerModel(
      id: player.id,
      name: player.name,
      email: player.email,
      emailVerified: player.emailVerified,
      statistic: player.statistic,
    );
  }

  factory PlayerModel.fromJson(Map<dynamic, dynamic> json) {
    return PlayerModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      emailVerified: json['emailVerified'],
      statistic: StatisticModel.fromJson(json['statistic']),
    );
  }

  Player toPlayer() {
    return Player(
      id: id,
      name: name,
      email: email,
      emailVerified: emailVerified,
      statistic: statistic,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'emailVerified': emailVerified,
      'statistic': (statistic as StatisticModel).toJson()
    };
  }
}
