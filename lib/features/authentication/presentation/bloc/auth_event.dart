import 'package:answer_five/features/authentication/presentation/bloc/auth_state.dart';
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
  final String confirmedPassword;

  const AuthRegisterPressed(
      {required this.email,
      required this.password,
      required this.confirmedPassword});

  @override
  List<Object> get props => [email, password];
}

class AuthPageFiltered extends AuthEvent {
  final AuthFilter authFilter;

  const AuthPageFiltered(this.authFilter);

  @override
  List<Object> get props => [authFilter];
}

class AuthLogoutPressed extends AuthEvent {
  const AuthLogoutPressed();
}

class AuthPhotoUrlUpdated extends AuthEvent {
  final String path;
  final String name;

  const AuthPhotoUrlUpdated({required this.path, required this.name});
}
