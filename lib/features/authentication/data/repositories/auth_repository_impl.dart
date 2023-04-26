import 'package:answer_five/core/errors/exceptions.dart';
import 'package:answer_five/core/errors/failures.dart';
import 'package:answer_five/core/success.dart';
import 'package:answer_five/core/usecases/usecase.dart';
import 'package:answer_five/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:answer_five/features/authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/player.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDatasource _authLocalDatasource;

  const AuthRepositoryImpl(this._authLocalDatasource);

  @override
  Stream<Player> authStateChanges() {
    final playerModel = _authLocalDatasource.authStateChanges();
    return playerModel.asyncMap((playerModel) => playerModel.toPlayer());
  }

  @override
  Future<Either<Failure, Success>> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      await _authLocalDatasource.loginWithEmailAndPassword(email, password);
      return const Right(Success());
    } on AuthException catch (error) {
      return Left(AuthFailure(error.message));
    } on NetworkException catch (error) {
      return Left(NetworkFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, Success>> registerUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _authLocalDatasource.registerUserWithEmailAndPassword(
          email, password);
      return const Right(Success());
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

  @override
  Future<Either<Failure, Success>> updatePhotoURL(
      UpdatePhotoUrlParams params) async {
    try {
      await _authLocalDatasource.updatePhotoURL(params);
      return const Right(Success());
    } on AuthException catch (error) {
      return Left(AuthFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, Success>> updateUsername(String username) async {
    try {
      await _authLocalDatasource.updateUsername(username);
      return const Right(Success());
    } on AuthException catch (error) {
      return Left(AuthFailure(error.message));
    }
  }
}
