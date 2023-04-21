import 'package:answer_five/features/authentication/domain/entities/player.dart';
import 'package:answer_five/features/home/data/datasources/home_remote_datasource.dart';
import 'package:answer_five/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDatasource _datasource;

  const HomeRepositoryImpl(this._datasource);

  @override
  Stream<Player> getPlayer() {
    final playerModel = _datasource.getPlayer();
    return playerModel.map((playerModel) => playerModel.toPlayer());
  }
}
