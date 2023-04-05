import 'package:equatable/equatable.dart';

import '../../domain/entities/trivia_user.dart';

enum AuthFilter { registration, login }

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  final AuthFilter authFilter;
  const AuthInitial({required this.authFilter});

  @override
  List<Object> get props => [authFilter];
}

class AuthLoading extends AuthState {
  const AuthLoading();

  @override
  List<Object> get props => [];
}

class AuthLoadSuccess extends AuthState {
  final TriviaUser user;
  const AuthLoadSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthLoadFailure extends AuthState {
  final String errorMessage;
  const AuthLoadFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
