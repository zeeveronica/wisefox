import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wisefox/client/features/model/client_model.dart';
import 'package:wisefox/client/features/repos/Client_repos.dart';

import 'package:equatable/equatable.dart';
// Updated import

part 'client_event.dart';
part 'client_state.dart'; // Updated part file

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final ClientRepository studentRepository;

  ClientBloc(this.studentRepository) : super(ClientInitial()) {
    on<FetchClients>(_onFetchStudents);
  }

  Future<void> _onFetchStudents(
      FetchClients event, Emitter<ClientState> emit) async {
    emit(ClientLoading());
    try {
      final students = await studentRepository.fetchStudents();
      print('Students fetched: $students');
      emit(ClientLoaded(students));
    } catch (e) {
      emit(ClientError(e.toString()));
    }
  }
}
