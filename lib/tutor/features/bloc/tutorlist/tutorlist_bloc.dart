import 'package:bloc/bloc.dart';
import 'package:wisefox/client/features/model/academicyear_model.dart';
import 'package:wisefox/client/features/repos/tutorlist_repos.dart';
import 'package:equatable/equatable.dart';

part 'tutorlist_event.dart';
part 'tutorlist_state.dart';

class AcademicYearBloc extends Bloc<AcademicYearEvent, AcademicYearState> {
  final AcademicYearRepository tutorListRepository;

  AcademicYearBloc(this.tutorListRepository) : super(AcademicYearInitial()) {
    on<FetchTutorList>((event, emit) async {
      emit(AcademicYearLoading());
      try {
        final tutorList = await tutorListRepository.fetchTutorList();
        emit(AcademicYearLoaded(tutorList));
      } catch (error) {
        print("Error: $error"); // Log the error for debugging
        emit(AcademicYearError(error.toString()));
      }
    });
  }

  // Direct method to fetch the tutor list
  Future<List<AcademicYearModel>> fetchTutorListDirectly() async {
    try {
      final tutorList = await tutorListRepository.fetchTutorList();
      return tutorList;
    } catch (error) {
      throw Exception("Failed to fetch tutor list: $error");
    }
  }
}
