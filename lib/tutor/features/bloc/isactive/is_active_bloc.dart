import 'package:bloc/bloc.dart';
import 'package:wisefox/client/features/repos/isactive_repos.dart';
import 'package:equatable/equatable.dart';

part 'is_active_event.dart';
part 'is_active_state.dart';

class IsActiveBloc extends Bloc<IsActiveEvent, IsActiveState> {
  final IsActiveRepository repository;

  IsActiveBloc(this.repository) : super(IsActiveInitial()) {
    on<IsActiveRequested>(_onIsActiveRequested);
  }

  Future<void> _onIsActiveRequested(
    IsActiveRequested event,
    Emitter<IsActiveState> emit,
  ) async {
    emit(IsActiveLoading());
    try {
      final response = await repository.toggleStatus(
        studentId: event.studentId,
        status: event.status,
      );
      if (response.statusCode != 200) {
        emit(IsActiveFailure(
          error: 'Failed to change status. Status code: ${response.statusCode}',
        ));
        return;
      }
      emit(IsActiveSuccess(newStatus: event.status)); // Pass the updated status
    } catch (e) {
      emit(IsActiveFailure(error: e.toString()));
    }
  }
}
