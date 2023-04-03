import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';

import '../../domain/entities/trivia.dart';
import '../../domain/repositories/trivia_repository.dart';
import '../datasources/remote_data_source.dart';

class TriviaRepositoryImpl implements TriviaRepository {
  final RemoteDataSource _remoteDataSource;

  const TriviaRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, Trivia>> getTrivia() async {
    try {
      final getTrivia = await _remoteDataSource.getTrivia();
      return Right(getTrivia);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }
}
