import 'package:equatable/equatable.dart';

abstract class Success extends Equatable {
  final String message;
  const Success(this.message);
}

class LoginSuccess extends Success {
  const LoginSuccess(super.message);

  @override
  List<Object> get props => [message];
}

class RegisterSuccess extends Success {
  const RegisterSuccess(super.message);

  @override
  List<Object> get props => [message];
}

class LogoutSuccess extends Success {
  const LogoutSuccess(super.message);

  @override
  List<Object> get props => [message];
}
