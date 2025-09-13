part of 'user_bloc.dart';

class UserState extends Equatable {
  final User? user;
  final bool isEditing;

  const UserState({this.user, this.isEditing = false});

  factory UserState.initial() => UserState(user: null, isEditing: false);

  UserState copyWith({User? user, bool? isEditing}) {
    return UserState(
      user: user ?? this.user,
      isEditing: isEditing ?? this.isEditing,
    );
  }

  @override
  List<Object?> get props => [user ?? '', isEditing];
}
