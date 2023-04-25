import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class AuthFailure extends Failure {
  const AuthFailure(super.message);

  @override
  List<Object> get props => [message];
}

class InputFailure extends Failure {
  const InputFailure(super.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);

  @override
  List<Object> get props => [message];
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);

  @override
  List<Object> get props => [message];
}

class CameraFailure extends Failure {
  const CameraFailure(super.message);
  @override
  List<Object> get props => [message];
}
