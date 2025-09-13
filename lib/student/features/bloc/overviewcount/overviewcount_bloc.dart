import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wisefox/student/features/model/overview_model.dart';
import 'package:wisefox/student/features/repos/overview_repos.dart';

part 'overviewcount_event.dart';
part 'overviewcount_state.dart';

class OverviewBloc extends Bloc<OverviewEvent, OverviewState> {
  final OverviewRepository overviewRepository;

  OverviewBloc(this.overviewRepository) : super(OverviewLoading()) {
    // Handling the FetchOverviewCount event
    on<FetchOverviewCount>(_onFetchOverviewCount);
  }

  // Method to handle FetchOverviewCount event
  Future<void> _onFetchOverviewCount(
      FetchOverviewCount event, Emitter<OverviewState> emit) async {
    emit(OverviewLoading());
    try {
      final overviewCount = await overviewRepository.fetchOverviewCount();
      emit(OverviewLoaded(overviewCount));
    } catch (e) {
      emit(OverviewError(e.toString()));
    }
  }
}
