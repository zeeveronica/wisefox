part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginButtonPressed extends AuthEvent {
  final String email;
  final String password;
  LoginButtonPressed({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}

class CheckLoginStatus extends AuthEvent {}

class LogoutButtonPressed extends AuthEvent {}
