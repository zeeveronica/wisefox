import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wisefox/student/features/model/tutorcount_model.dart';
import 'package:wisefox/student/features/repos/tutorlist_repos.dart';

part 'tutorlist_event.dart';
part 'tutorlist_state.dart';

class TutorlistBloc extends Bloc<TutorListEvent, TutorListState> {
  final TutorListRepository tutorListRepository;

  TutorlistBloc(this.tutorListRepository) : super(TutorListInitial()) {
    on<FetchTutorList>((event, emit) async {
      emit(TutorListLoading());
      try {
        final tutorList = await tutorListRepository.fetchTutorList();
        emit(TutorListLoaded(tutorList));
      } catch (error) {
        print("Error: $error"); // Log the error for debugging
        emit(TutorListError(error.toString()));
      }
    });
  }

  // Direct method to fetch the tutor list
  Future<List<TutorList>> fetchTutorListDirectly() async {
    try {
      final tutorList = await tutorListRepository.fetchTutorList();
      return tutorList;
    } catch (error) {
      throw Exception("Failed to fetch tutor list: $error");
    }
  }
}
