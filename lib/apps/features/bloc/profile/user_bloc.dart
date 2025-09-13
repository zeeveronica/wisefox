import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wisefox/apps/model/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState.initial()) {
    on<LoadUser>((event, emit) {
      emit(state.copyWith(user: event.user));
    });

    on<ToggleEdit>((event, emit) {
      emit(state.copyWith(isEditing: !state.isEditing));
    });

    on<UpdateBasicDetails>((event, emit) {
      final updatedUser = state.user?.copyWith(
        firstName: event.firstName,
        lastName: event.lastName,
      );
      emit(state.copyWith(user: updatedUser, isEditing: false));
    });
  }
}
