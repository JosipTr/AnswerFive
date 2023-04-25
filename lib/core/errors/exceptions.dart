import '../utils/constants/string_constants.dart';

class AuthException implements Exception {
  final String message;
  const AuthException(this.message);
}

class ServerException implements Exception {
  final String message;

  const ServerException(
      {this.message = StringConstants.serverExceptionMessage});
}

class NetworkException implements Exception {
  final String message;

  const NetworkException(
      {this.message = StringConstants.networkExceptionMessage});
}

class CameraExc implements Exception {
  final String message;

  const CameraExc({this.message = "CameraFailure"});
}
