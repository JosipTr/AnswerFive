import 'package:equatable/equatable.dart';

class Player extends Equatable {
  final String id;
  final String name;
  final String email;
  final bool emailVerified;
  const Player(
      {required this.id,
      required this.name,
      required this.email,
      required this.emailVerified});

  Player copyWith(
      {String? id, String? name, String? email, bool? emailVerified}) {
    return Player(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        emailVerified: emailVerified ?? this.emailVerified);
  }

  @override
  List<Object> get props => [id, name, email, emailVerified];
}
