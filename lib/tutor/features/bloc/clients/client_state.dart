part of 'client_bloc.dart';

abstract class ClientState extends Equatable {
  const ClientState();

  @override
  List<Object> get props => [];
}

class ClientInitial extends ClientState {}

class ClientLoading extends ClientState {}

class ClientLoaded extends ClientState {
  final List<ClientModel> clients;

  const ClientLoaded(this.clients);

  @override
  List<Object> get props => [clients];
}

class ClientError extends ClientState {
  final String message;

  const ClientError(this.message);

  @override
  List<Object> get props => [message];
}
