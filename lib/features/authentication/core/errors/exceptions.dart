import 'package:equatable/equatable.dart';

class AuthException extends Equatable implements Exception {
  final String message;
  const AuthException(this.message);

  @override
  List<Object> get props => [message];
}
