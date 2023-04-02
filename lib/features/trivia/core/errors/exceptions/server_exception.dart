import '../../utils/constants/string_constants.dart';

class ServerException implements Exception {
  final String message;

  const ServerException(
      {this.message = StringConstants.serverExceptionMessage});
}
