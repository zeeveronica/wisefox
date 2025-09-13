part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class LoadUser extends UserEvent {
  final User user;
  const LoadUser(this.user);
}

class ToggleEdit extends UserEvent {}

class UpdateBasicDetails extends UserEvent {
  final String firstName;
  final String lastName;

  const UpdateBasicDetails({required this.firstName, required this.lastName});

  @override
  List<Object?> get props => [firstName, lastName];
}