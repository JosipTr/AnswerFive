import 'package:answer_five/features/authentication/domain/entities/player.dart';
import 'package:answer_five/features/authentication/domain/repositories/auth_repository.dart';

class AuthStateChanges {
  final AuthRepository _authRepository;

  const AuthStateChanges(this._authRepository);

  Stream<Player> call() {
    return _authRepository.authStateChanges();
  }
}
