import 'package:bloc/bloc.dart';
import 'package:wisefox/client/features/model/subject_model.dart';
import 'package:wisefox/client/features/repos/selectsubject.dart';
import 'package:equatable/equatable.dart';

part 'subject_event.dart';
part 'subject_state.dart';

class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  final SubjectRepository subjectRepository;

  SubjectBloc(this.subjectRepository) : super(SubjectInitial()) {
    on<FetchSubjectList>((event, emit) async {
      emit(SubjectLoading());
      try {
        final subjectList = await subjectRepository.fetchSubjectList();
        emit(SubjectLoaded(subjectList));
      } catch (error) {
        print("Error: $error"); // Log the error for debugging
        emit(SubjectError(error.toString()));
      }
    });
  }

  // Direct method to fetch the subject list
  Future<List<SubjectModel>> fetchSubjectListDirectly() async {
    try {
      final subjectList = await subjectRepository.fetchSubjectList();
      return subjectList;
    } catch (error) {
      throw Exception("Failed to fetch subject list: $error");
    }
  }
}
