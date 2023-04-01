import 'package:answer_five/features/authentication/domain/entities/trivia_user.dart';
import 'package:answer_five/features/authentication/domain/repositories/auth_repository.dart';

class AuthStateChanges {
  final AuthRepository _authRepository;

  const AuthStateChanges(this._authRepository);

  Stream<TriviaUser> call() {
    return _authRepository.authStateChanges();
  }
}
