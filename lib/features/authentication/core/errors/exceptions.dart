import 'package:equatable/equatable.dart';

class AuthenticationException extends Equatable implements Exception {
  final String message;
  const AuthenticationException(
      {this.message = 'Authentication error occurred!'});

  @override
  List<Object> get props => [message];
}
