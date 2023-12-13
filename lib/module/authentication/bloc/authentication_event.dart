part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

final class SingInWithGoogleEvent extends AuthenticationEvent {
  const SingInWithGoogleEvent();
}

final class LogoutEvent extends AuthenticationEvent {
  const LogoutEvent();
}

