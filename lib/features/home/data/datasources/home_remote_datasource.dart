import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../authentication/data/models/player_model.dart';

abstract class HomeRemoteDatasource {
  Stream<PlayerModel> getPlayer();
}

class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseDatabase _firebaseDatabase;

  const HomeRemoteDatasourceImpl(this._firebaseAuth, this._firebaseDatabase);

  @override
  Stream<PlayerModel> getPlayer() {
    return _firebaseDatabase
        .ref()
        .child("players/${_firebaseAuth.currentUser!.uid}")
        .onValue
        .map((event) => PlayerModel.fromJson(
            event.snapshot.value as Map<dynamic, dynamic>));
  }
}
