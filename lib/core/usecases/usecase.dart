import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../features/statistic/domain/entities/statistic.dart';
import '../errors/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {
  const NoParams();
}

class EmailAndPasswordParams {
  final String email;
  final String password;
  final String? confirmedPassword;

  const EmailAndPasswordParams(
      {required this.email, required this.password, this.confirmedPassword});
}

class UpdatePlayerStatsParams {
  final Statistic statistic;
  final bool isCorrect;

  const UpdatePlayerStatsParams(this.statistic, this.isCorrect);
}

class StatsParams {
  final String id;
  final bool? isCorrect;
  const StatsParams(this.id, {this.isCorrect});
}

class UploadImageParams {
  final XFile xFile;
  const UploadImageParams(this.xFile);
}
