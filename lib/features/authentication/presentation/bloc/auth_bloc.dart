import 'package:answer_five/core/usecases/usecase.dart';
import 'package:answer_five/features/authentication/domain/usecases/auth_state_changes.dart';
import 'package:answer_five/features/authentication/domain/usecases/login_with_email_and_password.dart';
import 'package:answer_five/features/authentication/domain/usecases/register_user_with_email_and_password.dart';
import 'package:answer_five/features/authentication/presentation/bloc/auth_event.dart';
import 'package:answer_five/features/authentication/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/logout.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthStateChanges _authStateChanges;
  final RegisterUserWithEmailAndPassword _registerUserWithEmailAndPassword;
  final LoginWithEmailAndPassword _loginWithEmailAndPassword;
  final Logout _logout;

  AuthBloc(this._authStateChanges, this._registerUserWithEmailAndPassword,
      this._loginWithEmailAndPassword, this._logout)
      : super(const AuthInitial(authFilter: AuthFilter.login)) {
    on<AuthStarted>(_onAuthStarted);
    on<AuthRegisterPressed>(_onAuthRegisterPressed);
    on<AuthLoginPressed>(_onAuthLoginPressed);
    on<AuthPageFiltered>(_onAuthPageFiltered);
    on<AuthLogoutPressed>(_onAuthLogoutPressed);
  }

  void _onAuthStarted(AuthStarted event, Emitter<AuthState> emit) async {
    final playerStream = _authStateChanges();
    await emit.forEach(
      playerStream,
      onData: (player) => AuthLoadSuccess(player: player),
      onError: (_, __) => const AuthInitial(authFilter: AuthFilter.login),
    );
  }

  Future<void> _onAuthRegisterPressed(
      AuthRegisterPressed event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    await _registerUserWithEmailAndPassword(EmailAndPasswordParams(
        email: event.email,
        password: event.password,
        confirmedPassword: event.confirmedPassword));
  }

  Future<void> _onAuthLoginPressed(
      AuthLoginPressed event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    await _loginWithEmailAndPassword(
        EmailAndPasswordParams(email: event.email, password: event.password));
  }

  void _onAuthPageFiltered(AuthPageFiltered event, Emitter<AuthState> emit) {
    emit(AuthInitial(authFilter: event.authFilter));
  }

  Future<void> _onAuthLogoutPressed(
      AuthLogoutPressed event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    await _logout(const NoParams());
  }
}
