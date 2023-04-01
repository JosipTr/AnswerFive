import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationLocalDatasource {
  Stream<User?> authStateChanges();
}
