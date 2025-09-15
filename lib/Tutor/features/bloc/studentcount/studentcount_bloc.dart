import 'package:bloc/bloc.dart';
import 'package:wisefox/client/features/repos/studentcount_repos.dart';
import 'package:equatable/equatable.dart';

part 'studentcount_event.dart';
part 'studentcount_state.dart';

class StudentCountBloc extends Bloc<StudentCountEvent, StudentCountState> {
  final StudentCountRepository studentcountRepository;

  StudentCountBloc(this.studentcountRepository) : super(StudentCountInitial()) {
    on<FetchStudentCount>(_onFetchStudentCount);
  }

  Future<void> _onFetchStudentCount(
      FetchStudentCount event, Emitter<StudentCountState> emit) async {
    emit(StudentCountLoading());
    try {
      final studentData = await studentcountRepository.fetchAllData();

      final studentCount = studentData['student_count'] as int;
      final activeStudents = studentData['active_students'] as int;
      final inactiveStudents = studentData['inactive_students'] as int;
      final onLeaveStudents = studentData['on_leave_students'] as int;

      emit(StudentCountLoaded(
        studentCount: studentCount,
        activeStudents: activeStudents,
        inactiveStudents: inactiveStudents,
        onLeaveStudents: onLeaveStudents,
      ));
    } catch (e) {
      emit(StudentCountError(e.toString()));
    }
  }
}
