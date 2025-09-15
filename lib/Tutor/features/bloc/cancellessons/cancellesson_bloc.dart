import 'package:bloc/bloc.dart';
import 'package:wisefox/client/features/repos/cancellesson_repos.dart';
import 'package:equatable/equatable.dart';

part 'cancellesson_event.dart';
part 'cancellesson_state.dart';

class CancelLessonBloc extends Bloc<CancelLessonEvent, CancelLessonState> {
  final CancelLessonRepository repository;

  CancelLessonBloc(this.repository) : super(CancelLessonInitial()) {
    on<CancelLessonRequested>(_onCancelLessonRequested);
  }
  Future<void> _onCancelLessonRequested(
    CancelLessonRequested event,
    Emitter<CancelLessonState> emit,
  ) async {
    emit(CancelLessonLoading());
    try {
      final response = await repository.cancelLesson(
        id: event.id,
        reasonForCancellation: event.reasonForCancellation,
      );
      if (response.statusCode != 200) {
        emit(CancelLessonFailure(
          error: 'Failed to cancel lesson. Status code: ${response.statusCode}',
        ));
        return;
      }
      emit(CancelLessonSuccess());
    } catch (e) {
      emit(CancelLessonFailure(error: e.toString()));
    }
  }
}
