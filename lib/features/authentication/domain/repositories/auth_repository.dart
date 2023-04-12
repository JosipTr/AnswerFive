import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/success.dart';
import '../entities/player.dart';

abstract class AuthRepository {
  Stream<Player> authStateChanges();
  Future<Either<Failure, Player>> registerUserWithEmailAndPassword(
      String email, String password);

  Future<Either<Failure, Player>> loginWithEmailAndPassword(
      String email, String password);

  Future<Either<Failure, Success>> logout();
}
