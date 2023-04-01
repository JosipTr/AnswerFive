import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthStarted extends AuthEvent {}

class AuthLoginPressed extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginPressed({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class AuthRegisterPressed extends AuthEvent {
  final String email;
  final String password;

  const AuthRegisterPressed({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
