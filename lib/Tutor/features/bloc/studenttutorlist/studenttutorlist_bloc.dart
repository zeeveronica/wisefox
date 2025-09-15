import 'package:bloc/bloc.dart';
import 'package:wisefox/client/features/model/tutorlist_model.dart';
import 'package:wisefox/client/features/repos/studenttutorlist_repos.dart';
import 'package:equatable/equatable.dart';

part 'studenttutorlist_event.dart';
part 'studenttutorlist_state.dart';

class TutorlistBloc extends Bloc<TutorEvent, TutorState> {
  final Tutorlistrepo repository;

  TutorlistBloc(this.repository) : super(TutorInitial()) {
    on<FetchTutorList>(_onLoadUser);
  }

  Future<void> _onLoadUser(
    FetchTutorList event,
    Emitter<TutorState> emit,
  ) async {
    emit(TutorLoading());
    try {
      final tutors = await repository.Tutorlistclasses();
      emit(TutorLoaded(tutors));
    } catch (e) {
      emit(TutorError('Failed to load tutor details: ${e.toString()}'));
    }
  }
}
