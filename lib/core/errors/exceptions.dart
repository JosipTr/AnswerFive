import 'package:equatable/equatable.dart';

import '../utils/constants/string_constants.dart';

class AuthException extends Equatable implements Exception {
  final String message;
  const AuthException(this.message);

  @override
  List<Object> get props => [message];
}

class ServerException implements Exception {
  final String message;

  const ServerException(
      {this.message = StringConstants.serverExceptionMessage});
}
