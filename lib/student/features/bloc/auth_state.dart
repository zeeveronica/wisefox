part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class PrepInitial extends AuthState {}

class PrepLoading extends AuthState {}

class PrepSuccess extends AuthState {
  final String accessToken;
  final int studentId;
  PrepSuccess({
    required this.accessToken,
    required this.studentId,
  });
  @override
  List<Object> get props => [accessToken, studentId];
}

class PrepFailure extends AuthState {
  final String error;
  PrepFailure({required this.error});
  @override
  List<Object> get props => [error];
}
