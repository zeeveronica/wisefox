
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String accessToken;
  final int Userid;
  final int Tutorid;

  LoginSuccess(this.accessToken, this.Userid, this.Tutorid);

  @override
  List<Object?> get props => [accessToken, Userid,Tutorid];
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);

  @override
  List<Object?> get props => [error];
}
class LoginLogoutSuccess extends LoginState {}

abstract class ClassesState extends Equatable {
  @override
  List<Object> get props => [];
}
