import 'package:equatable/equatable.dart';

class AuthException extends Equatable implements Exception {
  final String message;
  const AuthException({this.message = 'Authentication error occurred!'});

  @override
  List<Object> get props => [message];
}
