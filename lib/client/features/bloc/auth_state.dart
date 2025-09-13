part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class PrepInitial extends AuthState {}

class PrepLoading extends AuthState {}

class PrepSuccess extends AuthState {
  final String accessToken;
  final String refreshToken;
  final int clientid;
  final int userid;
  final String referralcode;
  PrepSuccess({
    required this.accessToken,
    required this.refreshToken,
    required this.clientid,
    required this.userid,
    required this.referralcode,
  });
  @override
  List<Object> get props => [
        accessToken,
        refreshToken,
        clientid,
        userid,
        referralcode,
      ];
}

class PrepFailure extends AuthState {
  final String error;
  PrepFailure({required this.error});
  @override
  List<Object> get props => [error];
}

class LogoutSuccess extends AuthState {}
