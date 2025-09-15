import 'package:bloc/bloc.dart';
import 'package:wisefox/client/features/model/studentoverview_model.dart';
import 'package:wisefox/client/features/repos/studentoverview_repos.dart';
import 'package:equatable/equatable.dart';

part 'studentoverviewcount_event.dart';
part 'studentoverviewcount_state.dart';

class StudentOverviewCountBloc
    extends Bloc<StudentOverviewCountEvent, StudentOverviewCountState> {
  final StudentOverviewRepository studentoverviewRepository; // Change here

  StudentOverviewCountBloc(this.studentoverviewRepository)
      : super(StudentOverviewCountInitial()) {
    on<FetchStudentOverviewCount>(_onFetchStudentOverviewCount);
  }

  Future<void> _onFetchStudentOverviewCount(FetchStudentOverviewCount event,
      Emitter<StudentOverviewCountState> emit) async {
    emit(StudentOverviewCountLoading());
    try {
      final overviewCount = await studentoverviewRepository
          .fetchStudentOverviewCount(); // Correct method name
      emit(StudentOverviewCountLoaded(overviewCount)); // Correct type here
    } catch (e) {
      emit(StudentOverviewCountError(e.toString()));
    }
  }
}
