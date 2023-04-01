import 'package:equatable/equatable.dart';

import '../../domain/entities/trivia_user.dart';

enum AuthStatus { initial, loading, success, failure }

class AuthState extends Equatable {
  final AuthStatus authStatus;
  final TriviaUser? triviaUser;

  const AuthState({this.authStatus = AuthStatus.initial, this.triviaUser});

  @override
  List<Object> get props => [];
  AuthState copyWith({AuthStatus? authStatus, TriviaUser? triviaUser}) {
    return AuthState(
        authStatus: authStatus ?? this.authStatus,
        triviaUser: triviaUser ?? this.triviaUser);
  }
}
