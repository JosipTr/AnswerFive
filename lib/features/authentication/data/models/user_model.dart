import 'package:answer_five/features/single_player/domain/entities/statistic.dart';

import '../../domain/entities/trivia_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends TriviaUser {
  const UserModel(
      {required super.id,
      required super.name,
      required super.email,
      required super.statistic});

  factory UserModel.fromUser(User user) {
    return UserModel(
        id: user.uid,
        name: user.displayName ?? 'empty',
        email: user.email ?? 'empty',
        statistic: const Statistic());
  }

  TriviaUser toTriviaUser() {
    return TriviaUser(
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
      'statistic': statistic.toJson()
    };
  }
}
