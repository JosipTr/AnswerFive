import '../../domain/entities/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends TriviaUser {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
  });

  factory UserModel.fromUser(User user) {
    return UserModel(
      id: user.uid,
      name: user.displayName ?? 'empty',
      email: user.email ?? 'empty',
    );
  }

  TriviaUser toTriviaUser() {
    return TriviaUser(
      id: id,
      name: name,
      email: email,
    );
  }
}
