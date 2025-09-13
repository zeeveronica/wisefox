import 'package:bloc/bloc.dart';
import 'package:wisefox/client/features/repos/studentadmissionpost_repos.dart';
import 'package:equatable/equatable.dart';

part 'studentadmission_event.dart';
part 'studentadmission_state.dart';

class StudentAdmissionBloc
    extends Bloc<StudentAdmissionEvent, StudentAdmissionState> {
  final StudentAdmissionRepository repository;

  StudentAdmissionBloc(this.repository) : super(StudentAdmissionInitial()) {
    on<StudentAdmissionEvent>(_onSubmitStudentAdmission);
  }

  Future<void> _onSubmitStudentAdmission(
      StudentAdmissionEvent event, Emitter<StudentAdmissionState> emit) async {
    emit(StudentAdmissionLoading());

    try {
      // Ensure country is passed as an integer
      final response = await repository.postStudentAdmission(
        firstName: event.firstName,
        lastName: event.lastName,
        username: event.username,
        email: event.email,
        phoneNumber: event.phoneNumber,
        dateOfBirth: event.dateOfBirth,
        gender: event.gender,
        year: event.year,
        country: event.country, // Ensure this is an integer
        subjects: event.subjects, // Already a list of maps as required
        // studentPhoto is not needed since it's fetched in the repository
      );

      if (response.statusCode == 200) {
        emit(StudentAdmissionSuccess());
      } else {
        emit(StudentAdmissionFailure(
            error:
                'Failed to submit data. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(StudentAdmissionFailure(error: e.toString()));
    }
  }
}
