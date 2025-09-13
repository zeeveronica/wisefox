import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wisefox/student/features/repos/auth_repos.dart';
import 'package:wisefox/student/features/service/shared_preferences.dart';
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
      final studentId = result['studentId'];

      if (statusCode == 200 && accessToken != null) {
        await SharedPreferencesHelper.saveData("loginData", {
          "token": accessToken,
          "studentId": studentId,
        });
        emit(PrepSuccess(accessToken: accessToken, studentId: studentId));
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
        final studentId = loginData["activeId"] ?? 0;

        emit(PrepSuccess(
          accessToken: accessToken,
          studentId: studentId,
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
    try {
      // Remove the specific data (i.e., loginData)
      await SharedPreferencesHelper.removeData("loginData");

      // Optionally, emit a state indicating that the user has logged out
      emit(PrepInitial());
    } catch (e) {
      print('Error during logout: $e');
      emit(PrepFailure(error: e.toString()));
    }
  }
}
