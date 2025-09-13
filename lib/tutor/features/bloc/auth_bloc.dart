import 'dart:developer';

import 'package:wisefox/client/features/repos/auth_repos.dart';
import 'package:wisefox/client/features/service/shared_preferences.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(PrepInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<CheckLoginStatus>(_onCheckLoginStatus);
    on<LogoutButtonPressed>(_onLogoutButtonPressed);
  }
  Future<void> _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<AuthState> emit) async {
    emit(PrepLoading());
    try {
      final result = await authRepository.authenticate(
        email: event.email,
        password: event.password,
      );

      final statusCode = result['statusCode'];
      final accessToken = result['accessToken'];
      final refreshToken = result['refresh'];
      final clientid = result['clientid'];
      final userid = result['userid'];
      final referralcode = result['referralcode'];

      if (statusCode == 200 && accessToken != null) {
        await SharedPreferencesHelper.saveData("loginData", {
          "token": accessToken,
          "refresh": refreshToken,
          "clientid": clientid,
          "userid": userid,
          "referralcode": referralcode
        });
        emit(PrepSuccess(
          accessToken: accessToken,
          refreshToken: refreshToken,
          clientid: clientid,
          userid: userid,
          referralcode: referralcode,
        ));
      } else {
        emit(PrepFailure(error: 'Invalid username or password'));
      }
    } catch (e) {
      emit(PrepFailure(
          error: "Please enter your username & password".toString()));
    }
  }

  Future<void> _onCheckLoginStatus(
      CheckLoginStatus event, Emitter<AuthState> emit) async {
    try {
      final loginData = await SharedPreferencesHelper.getData("loginData");
      if (loginData != null && loginData["token"] != null) {
        final accessToken = loginData["token"];
        final refreshToken = loginData["refresh"];
        final clientid = loginData["clientid"] ?? 0;
        final userid = loginData["userid"] ?? 0;
        final referralcode = loginData["referralcode"] ?? "";

        emit(PrepSuccess(
          accessToken: accessToken,
          refreshToken: refreshToken,
          clientid: clientid,
          userid: userid,
          referralcode: referralcode,
        ));
      } else {
        emit(PrepInitial());
      }
    } catch (e) {
      print('Error checking login status: $e');
      emit(PrepFailure(error: e.toString()));
    }
  }

  Future<void> _onLogoutButtonPressed(
      LogoutButtonPressed event, Emitter<AuthState> emit) async {
    emit(PrepLoading());
    try {
      final loginData = await SharedPreferencesHelper.getData('loginData');

      if (loginData == null || loginData['refresh'] == null) {
        throw Exception('No refresh token found');
      }

      final refreshToken = loginData['refresh'];
      log("ggghh $refreshToken");

      await authRepository.logout(refreshToken, event.context);

      // Remove the specific data (i.e., loginData)
      await SharedPreferencesHelper.removeData("loginData");

      // Emit a state indicating that the user has logged out
      emit(LogoutSuccess());
      emit(PrepInitial());
    } catch (e) {
      print('Error during logout: $e');
      emit(PrepFailure(error: e.toString()));
    }
  }
}
