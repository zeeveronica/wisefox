import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wisefox/apps/features/repos/auth_repos.dart';
import 'package:wisefox/apps/model/user.dart';
import 'package:wisefox/student/features/service/shared_preferences.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<CheckLoginStatus>(_onCheckLoginStatus);
    on<Logout>(_onLogout);
  }
  Future<void> _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // Authenticate and get User object
      final user = await authRepository.authenticate(
        username: event.username,
        password: event.password,
      );

      await SharedPreferencesHelper.saveData(
        "loginData",
        jsonEncode({
          "token": user.token,
          "refresh": user.refresh,
          "user": user.toJson(),
        }),
      );


      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }


  Future<void> _onCheckLoginStatus(
      CheckLoginStatus event, Emitter<AuthState> emit) async {
    try {
      final loginData = await SharedPreferencesHelper.getData("loginData");

      if (loginData != null && loginData["user"] != null) {
        // Reconstruct the User object from stored JSON
        final userJson = Map<String, dynamic>.from(loginData["user"]);
        final tokenData = {
          "token": loginData["token"],
          "refresh": loginData["refresh"],
        };
        final user = User.fromJson(userJson, tokenData: tokenData);

        emit(AuthSuccess(user));
      } else {
        emit(AuthInitial());
      }
    } catch (e) {
      print('Error checking login status: $e');
      emit(AuthFailure(error: e.toString()));
    }
  }

  Future<void> _onLogout(Logout event, Emitter<AuthState> emit) async {
    try {
      await SharedPreferencesHelper.clearData("loginData");  // 👈 Clear saved data
      emit(AuthInitial());  // 👈 Back to initial state
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }
}
