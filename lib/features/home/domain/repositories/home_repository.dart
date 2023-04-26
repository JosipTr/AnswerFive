import 'package:answer_five/features/authentication/domain/entities/player.dart';
import 'package:answer_five/features/statistic/domain/entities/statistic.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/success.dart';

abstract class HomeRepository {
  Stream<Player> getPlayer();

  Future<Either<Failure, Success>> updatePlayerStats(Statistic statistic);

  Stream<void> updateLastActive(String date);

  Future<Either<Failure, Success>> updateTodayQuestionNumber();

  Future<Either<Failure, Success>> uploadImage(XFile xFile);
}
