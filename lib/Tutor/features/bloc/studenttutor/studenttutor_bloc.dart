import 'package:bloc/bloc.dart';
import 'package:wisefox/client/features/model/tutor_model.dart';
import 'package:wisefox/client/features/repos/studenttutor_repos.dart';
import 'package:equatable/equatable.dart';

part 'studenttutor_event.dart';
part 'studenttutor_state.dart';

class StudentTutorBloc extends Bloc<StudentTutorEvent, StudentTutorState> {
  final StudentTutorRepository studentutorRepository;

  StudentTutorBloc(this.studentutorRepository) : super(StudentTutorInitial()) {
    on<FetchStudentTutors>(_onFetchTutors);
  }

  Future<void> _onFetchTutors(
      FetchStudentTutors event, Emitter<StudentTutorState> emit) async {
    emit(StudentTutorLoading());
    try {
      final tutorData = await studentutorRepository.fetchAllData();
      final tutors = tutorData['tutors'] as List<Tutor>;
      final tutorCount = tutorData['tutor_count'] as int;
      final activeTutors = tutorData['active_tutors'] as int;
      final onLeaveTutors = tutorData['on_leave_tutors'] as int;

      emit(StudentTutorLoaded(
        tutorCount: tutorCount,
        activeTutors: activeTutors,
        onLeaveTutors: onLeaveTutors,
        tutors: tutors,
      ));
    } catch (e) {
      emit(StudentTutorError(e.toString()));
    }
  }
}
