import 'package:bloc/bloc.dart';
import 'package:wisefox/client/features/model/examboard_model.dart';
import 'package:wisefox/client/features/repos/examboard_repo.dart';
import 'package:equatable/equatable.dart';

part 'examboard_event.dart';
part 'examboard_state.dart';

class ExamBoardBloc extends Bloc<ExamBoardEvent, ExamBoardState> {
  final ExamBoardRepository examBoardRepository;

  ExamBoardBloc(this.examBoardRepository) : super(ExamBoardInitial()) {
    on<FetchExamBoardList>((event, emit) async {
      emit(ExamBoardLoading());
      try {
        final examBoardList = await examBoardRepository.fetchExamBoardList();
        emit(ExamBoardLoaded(examBoardList));
      } catch (error) {
        print("Error: $error");
        emit(ExamBoardError(error.toString()));
      }
    });
  }

  // Direct method to fetch the exam board list
  Future<List<ExamBoardModel>> fetchExamBoardListDirectly() async {
    try {
      final examBoardList = await examBoardRepository.fetchExamBoardList();
      return examBoardList;
    } catch (error) {
      throw Exception("Failed to fetch exam board list: $error");
    }
  }
}
