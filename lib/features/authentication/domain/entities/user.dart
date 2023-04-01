import 'package:equatable/equatable.dart';

class TriviaUser extends Equatable {
  final String id;
  final String name;
  final String email;

  const TriviaUser({required this.id, required this.name, required this.email});

  TriviaUser copyWith({String? id, String? name, String? email}) {
    return TriviaUser(
        id: id ?? this.id, name: name ?? this.name, email: email ?? this.email);
  }

  @override
  List<Object> get props => [id, name, email];
}
