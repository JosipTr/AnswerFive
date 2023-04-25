import 'package:answer_five/features/home/domain/repositories/home_repository.dart';
import 'package:intl/intl.dart';

class UpdateLastActive {
  final HomeRepository _homeRepository;

  const UpdateLastActive(this._homeRepository);

  Stream<void> call() async* {
    final now = DateTime.now();
    final date = DateTime(now.year, now.month, now.day);
    final dateFormat = DateFormat('yyyy-MM-dd').format(date);
    yield* _homeRepository.updateLastActive(dateFormat);
  }
}
