import 'package:bloc/bloc.dart';
import 'package:wisefox/client/features/model/clientoverview_model.dart';
import 'package:wisefox/client/features/repos/clientoverview_repos.dart';
import 'package:equatable/equatable.dart';

part 'clientoverviewcount_event.dart';
part 'clientoverviewcount_state.dart';

class ClientOverviewBloc
    extends Bloc<ClientOverviewEvent, ClientOverviewState> {
  final ClientOverviewRepository clientoverviewRepository;

  ClientOverviewBloc(this.clientoverviewRepository)
      : super(ClientOverviewLoading()) {
    // Handling the FetchOverviewCount event
    on<FetchClientOverviewCount>(_onFetchOverviewCount);
  }

  // Method to handle FetchOverviewCount event
  Future<void> _onFetchOverviewCount(
      FetchClientOverviewCount event, Emitter<ClientOverviewState> emit) async {
    emit(ClientOverviewLoading());
    try {
      final overviewCount = await clientoverviewRepository.fetchOverviewCount();
      emit(ClientOverviewLoaded(overviewCount));
    } catch (e) {
      emit(ClientOverviewError(e.toString()));
    }
  }
}
