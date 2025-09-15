import 'package:bloc/bloc.dart';
import 'package:wisefox/client/features/model/dashboard_model.dart'; // Ensure this import is correct
import 'package:wisefox/client/features/repos/dashboard_repos.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository dashboardRepository;

  DashboardBloc(this.dashboardRepository) : super(DashboardLoading()) {
    on<FetchDashboardData>(_onFetchDashboardData);
  }

  // Method to handle FetchDashboardData event
  Future<void> _onFetchDashboardData(
      FetchDashboardData event, Emitter<DashboardState> emit) async {
    emit(DashboardLoading());
    try {
      final dashboardData = await dashboardRepository.fetchDashboardData();
      emit(DashboardLoaded(dashboardData!));
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }
}
