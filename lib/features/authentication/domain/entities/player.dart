import 'package:equatable/equatable.dart';

class Player extends Equatable {
  final String id;
  final String name;
  final String email;
  const Player({required this.id, required this.name, required this.email});

  Player copyWith({String? id, String? name, String? email}) {
    return Player(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  @override
  List<Object> get props => [id, name, email];
}
