import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/success.dart';
import '../entities/trivia_user.dart';

abstract class AuthRepository {
  Stream<TriviaUser> authStateChanges();
  Future<Either<Failure, TriviaUser>> registerUserWithEmailAndPassword(
      String email, String password);

  Future<Either<Failure, TriviaUser>> loginWithEmailAndPassword(
      String email, String password);

  Future<Either<Failure, Success>> logout();
}
