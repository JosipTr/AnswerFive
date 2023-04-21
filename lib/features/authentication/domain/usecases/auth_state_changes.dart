import 'package:answer_five/features/authentication/domain/repositories/auth_repository.dart';
import '../entities/player.dart';

class AuthStateChanges {
  final AuthRepository _authRepository;

  const AuthStateChanges(this._authRepository);

  Stream<Player> call() {
    return _authRepository.authStateChanges();
  }
}
