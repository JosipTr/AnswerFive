import 'package:equatable/equatable.dart';

import '../../../single_player/domain/entities/statistic.dart';

class TriviaUser extends Equatable {
  final String id;
  final String name;
  final String email;
  final Statistic statistic;

  const TriviaUser(
      {required this.statistic,
      required this.id,
      required this.name,
      required this.email});

  TriviaUser copyWith(
      {String? id, String? name, String? email, Statistic? statistic}) {
    return TriviaUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      statistic: statistic ?? this.statistic,
    );
  }

  @override
  List<Object> get props => [id, name, email];
}
