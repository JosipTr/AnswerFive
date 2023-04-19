import 'package:answer_five/core/errors/exceptions.dart';
import 'package:answer_five/core/errors/failures.dart';
import 'package:answer_five/core/success.dart';
import 'package:answer_five/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:answer_five/features/authentication/domain/entities/player.dart';
import 'package:answer_five/features/authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDatasource _authLocalDatasource;

  const AuthRepositoryImpl(this._authLocalDatasource);

  @override
  Stream<Player> authStateChanges() {
    final playerModelStream = _authLocalDatasource.authStateChanges();
    final playerStream =
        playerModelStream.map((playerModel) => playerModel!.toPlayer());
    return playerStream;
  }

  @override
  Future<Either<Failure, Player>> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      final playerModel =
          await _authLocalDatasource.loginWithEmailAndPassword(email, password);
      final player = playerModel.toPlayer();
      return Right(player);
    } on AuthException catch (error) {
      return Left(AuthFailure(error.message));
    } on NetworkException catch (error) {
      return Left(NetworkFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, Player>> registerUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final playerModel = await _authLocalDatasource
          .registerUserWithEmailAndPassword(email, password);
      final player = playerModel.toPlayer();
      return Right(player);
    } on AuthException catch (error) {
      return Left(AuthFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, Success>> logout() async {
    try {
      await _authLocalDatasource.logout();
      return const Right(Success());
    } on AuthException catch (error) {
      return Left(AuthFailure(error.message));
    }
  }
}
