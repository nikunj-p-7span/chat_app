import 'package:chat_app/module/authentication/repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;

  AuthenticationBloc({required this.authenticationRepository}) : super(AuthenticationInitial()) {
    on<SingInWithGoogleEvent>(_onSignInWithGoogle);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onSignInWithGoogle(
      SingInWithGoogleEvent event, Emitter<AuthenticationState> emit) async {
    try {
      emit(AuthenticationLoading());
      await authenticationRepository.signInWithGoogle();
      emit(AuthenticationSuccess());
    } catch (e) {
      emit(
        AuthenticationError(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthenticationState> emit) async {
    try {
      emit(LogoutLoading());
      await authenticationRepository.logout();
      emit(LogoutSuccess());
    } catch (e) {
      emit(
        LogoutError(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
