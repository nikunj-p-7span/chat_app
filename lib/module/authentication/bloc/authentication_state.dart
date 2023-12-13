part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {}

class AuthenticationError extends AuthenticationState {
  final String? errorMessage;

  AuthenticationError({this.errorMessage});
}

class LogoutLoading extends AuthenticationState {}

class LogoutSuccess extends AuthenticationState {}

class LogoutError extends AuthenticationState {
  final String? errorMessage;

  LogoutError({this.errorMessage});
}
