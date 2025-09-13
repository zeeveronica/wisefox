part of 'client_bloc.dart'; // Updated to match the new bloc file

abstract class ClientEvent extends Equatable {
  const ClientEvent();

  @override
  List<Object> get props => [];
}

class FetchClients extends ClientEvent {}
