import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wisefox/student/features/model/tutor_model.dart';
import 'package:wisefox/student/features/repos/tutor_repos.dart';

part 'tutor_event.dart';
part 'tutor_state.dart';

class TutorBloc extends Bloc<TutorEvent, TutorState> {
  final TutorRepository tutorRepository;

  TutorBloc(this.tutorRepository) : super(TutorInitial()) {
    on<FetchTutors>(_onFetchTutors);
    on<SearchTutors>(_onSearchTutors);
  }

  Future<void> _onFetchTutors(
      FetchTutors event, Emitter<TutorState> emit) async {
    emit(TutorLoading());
    try {
      final tutorData = await tutorRepository.fetchAllData();
      final tutors = tutorData['tutors'] as List<Tutor>;
      final tutorCount = tutorData['tutor_count'] as int;
      final activeTutors = tutorData['active_tutors'] as int;
      final onLeaveTutors = tutorData['on_leave_tutors'] as int;

      emit(TutorLoaded(
        tutorCount: tutorCount,
        activeTutors: activeTutors,
        onLeaveTutors: onLeaveTutors,
        tutors: tutors,
      ));
    } catch (e) {
      emit(TutorError(e.toString()));
    }
  }

  List<Tutor> _allTutors = [];

  Future<void> _onSearchTutors(SearchTutors event, Emitter<TutorState> emit) async {
    final query = event.query.toLowerCase();
    final filteredTutors = _allTutors.where((tutor) =>
        tutor.userName.toLowerCase().contains(query)
    ).toList();

    final tutorCount = filteredTutors.length;
    final activeTutors = filteredTutors.where((t) => t.isActive).length;
    final onLeaveTutors = filteredTutors.where((t) => !t.isActive).length;

    emit(TutorLoaded(
      tutorCount: tutorCount,
      activeTutors: activeTutors,
      onLeaveTutors: onLeaveTutors,
      tutors: filteredTutors,
    ));
  }

}
