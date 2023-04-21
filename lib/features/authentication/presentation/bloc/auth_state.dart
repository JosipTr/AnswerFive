import 'package:equatable/equatable.dart';

import '../../domain/entities/player.dart';

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
  final Player player;
  const AuthLoadSuccess({required this.player});

  @override
  List<Object> get props => [player];
}

class AuthLoadFailure extends AuthState {
  final String errorMessage;
  const AuthLoadFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
