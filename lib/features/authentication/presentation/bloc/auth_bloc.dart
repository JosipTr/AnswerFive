import 'package:answer_five/features/authentication/core/usecases/usecase.dart';
import 'package:answer_five/features/authentication/domain/usecases/auth_state_changes.dart';
import 'package:answer_five/features/authentication/domain/usecases/login_with_email_and_password.dart';
import 'package:answer_five/features/authentication/domain/usecases/register_user_with_email_and_password.dart';
import 'package:answer_five/features/authentication/presentation/bloc/auth_event.dart';
import 'package:answer_five/features/authentication/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthStateChanges _authStateChanges;
  final RegisterUserWithEmailAndPassword _registerUserWithEmailAndPassword;
  final LoginWithEmailAndPassword _loginWithEmailAndPassword;

  AuthBloc(this._authStateChanges, this._registerUserWithEmailAndPassword,
      this._loginWithEmailAndPassword)
      : super(const AuthState()) {
    on<AuthStarted>(_onAuthStarted);
    on<AuthRegisterPressed>(_onAuthRegisterPressed);
    on<AuthLoginPressed>(_onAuthLoginPressed);
  }

  void _onAuthStarted(AuthStarted event, Emitter<AuthState> emit) {
    final streamTriviaUser = _authStateChanges();
    emit.forEach(
      streamTriviaUser,
      onData: (triviaUser) => state.copyWith(
          authStatus: AuthStatus.success, triviaUser: triviaUser),
      onError: (_, __) => state.copyWith(authStatus: AuthStatus.failure),
    );
  }

  Future<void> _onAuthRegisterPressed(
      AuthRegisterPressed event, Emitter<AuthState> emit) async {
    await _registerUserWithEmailAndPassword(
        EmailAndPasswordParams(email: event.email, password: event.password));
  }

  Future<void> _onAuthLoginPressed(
      AuthLoginPressed event, Emitter<AuthState> emit) async {
    await _loginWithEmailAndPassword(
        EmailAndPasswordParams(email: event.email, password: event.password));
  }
}
