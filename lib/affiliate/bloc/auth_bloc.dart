
import 'dart:developer';

import 'package:wisefox/affiliate/Sharedpreferencehelper/sharedpreferencehelp.dart';
import 'package:wisefox/affiliate/bloc/auth_event.dart';
import 'package:wisefox/affiliate/bloc/auth_state.dart';
import 'package:wisefox/affiliate/repository/Authrepo.dart';


import 'package:bloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;

  LoginBloc(this._authRepository) : super(LoginInitial()) {
    on<LogoutRequested>(_onLogoutRequested);
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    try {
      // Perform login and get the access token and user ID
      final loginResponse = await _authRepository.login(
        email: event.email,
        password: event.password,
      );
      log("loginResponse is $loginResponse");
      final accessToken = loginResponse['token'];
      final int userId = loginResponse['userId'];
      final int tutorid = loginResponse['tutorId'] ?? 0;

      // Save the access token and user ID
      await SharedPreferencesHelper.saveData("loginData",
          {"token": accessToken, "userId": userId, "tutorId": tutorid});

      // Emit success state with the access token and user ID
      emit(LoginSuccess(accessToken, userId, tutorid));
    } catch (e) {
      // Emit failure state when login fails
      emit(LoginFailure(e.toString()));
    }
  }
Future<void> _onLogoutRequested(
      LogoutRequested event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    try {
      // Retrieve the refresh token from SharedPreferences
      final refreshToken = await SharedPreferencesHelper.getData('token');

      // Call the logout method with the refresh token
      await _authRepository.logout(refreshToken);

      emit(LoginLogoutSuccess());
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
  }
