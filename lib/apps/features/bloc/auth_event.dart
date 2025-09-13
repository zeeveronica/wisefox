part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginButtonPressed extends AuthEvent {
  final String username;
  final String password;
  LoginButtonPressed({required this.username, required this.password});

  @override
  List<Object?> get props => [username, password];
}

class CheckLoginStatus extends AuthEvent {}

class Logout extends AuthEvent {}
