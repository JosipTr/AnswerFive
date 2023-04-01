import 'package:equatable/equatable.dart';

import '../../domain/entities/trivia_user.dart';

enum AuthStatus { initial, loading, success, failure }

enum AuthFilter { registration, login }

class AuthState extends Equatable {
  final AuthStatus authStatus;
  final TriviaUser? triviaUser;
  final AuthFilter authFilter;
  final String? successMessage;
  final String? failureMessage;

  const AuthState({
    this.authStatus = AuthStatus.initial,
    this.triviaUser,
    this.authFilter = AuthFilter.login,
    this.failureMessage,
    this.successMessage,
  });

  @override
  List<Object?> get props => [authStatus, triviaUser, authFilter];
  AuthState copyWith({
    AuthStatus? authStatus,
    TriviaUser? triviaUser,
    AuthFilter? authFilter,
    String? successMessage,
    String? failureMessage,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      triviaUser: triviaUser ?? this.triviaUser,
      authFilter: authFilter ?? this.authFilter,
      successMessage: successMessage ?? this.successMessage,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }
}
