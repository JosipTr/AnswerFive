import 'package:answer_five/features/statistic/domain/entities/statistic.dart';
import 'package:equatable/equatable.dart';

class Player extends Equatable {
  final String id;
  final String name;
  final String email;
  final String lastActive;
  final Statistic statistic;

  const Player({
    required this.id,
    required this.name,
    required this.email,
    required this.lastActive,
    required this.statistic,
  });

  Player copyWith({
    String? id,
    String? name,
    String? email,
    String? lastActive,
    Statistic? statistic,
  }) {
    return Player(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      lastActive: lastActive ?? this.lastActive,
      statistic: statistic ?? this.statistic,
    );
  }

  @override
  List<Object> get props => [id, name, email, lastActive, statistic];
}
