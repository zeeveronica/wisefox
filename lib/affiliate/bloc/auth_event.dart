import 'package:equatable/equatable.dart';

class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginRequested extends LoginEvent {
  final String email;
  final String password;

  LoginRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}abstract class StudentEvent {}
class LogoutRequested extends LoginEvent {}

abstract class ClassesEvent extends Equatable {
  @override
  List<Object> get props => [];
}
