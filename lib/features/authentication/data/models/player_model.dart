import 'package:answer_five/features/statistic/domain/entities/statistic.dart';

import '../../../statistic/data/models/statistic_model.dart';
import '../../domain/entities/player.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      statistic: const StatisticModel(),
    );
  }

  factory PlayerModel.fromPlayer(Player player) {
    return PlayerModel(
      id: player.id,
      name: player.name,
      email: player.email,
      statistic: player.statistic,
    );
  }

  factory PlayerModel.fromMap(Map<dynamic, dynamic> map) {
    return PlayerModel(
        id: map['id'],
        name: map['name'],
        email: map['email'],
        statistic: map['statistic'] != null
            ? StatisticModel.fromJson(map['statistic'])
            : const Statistic());
  }

  Player toTriviaUser() {
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
      'statistic': {
        'correctAnswers': statistic.correctAnswers,
        'incorrectAnswers': statistic.incorrectAnswers,
        'totalQuestions': statistic.totalQuestions,
      },
    };
  }
}
