import 'package:answer_five/features/authentication/core/errors/exceptions.dart';
import 'package:answer_five/features/authentication/core/errors/failures.dart';
import 'package:answer_five/features/authentication/core/errors/success.dart';
import 'package:answer_five/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:answer_five/features/authentication/domain/entities/trivia_user.dart';
import 'package:answer_five/features/authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDatasource _authLocalDatasource;

  const AuthRepositoryImpl(this._authLocalDatasource);

  @override
  Stream<TriviaUser> authStateChanges() {
    final userModelStream = _authLocalDatasource.authStateChanges();
    final triviaUserStream =
        userModelStream.map((userModel) => userModel!.toTriviaUser());
    return triviaUserStream;
  }

  @override
  Future<Either<Failure, TriviaUser>> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      final userModel =
          await _authLocalDatasource.loginWithEmailAndPassword(email, password);
      final triviaUser = userModel.toTriviaUser();
      return Right(triviaUser);
    } on AuthException catch (error) {
      return Left(AuthFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, TriviaUser>> registerUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final userModel = await _authLocalDatasource
          .registerUserWithEmailAndPassword(email, password);
      final triviaUser = userModel.toTriviaUser();
      return Right(triviaUser);
    } on AuthException catch (error) {
      return Left(AuthFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, Success>> logout() async {
    try {
      await _authLocalDatasource.logout();
      return const Right(LogoutSuccess('Login Successful!'));
    } on AuthException catch (error) {
      return Left(AuthFailure(error.message));
    }
  }
}
