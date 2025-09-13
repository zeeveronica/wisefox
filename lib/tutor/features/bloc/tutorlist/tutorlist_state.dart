part of 'tutorlist_bloc.dart';

abstract class AcademicYearState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AcademicYearInitial extends AcademicYearState {}

class AcademicYearLoading extends AcademicYearState {}

class AcademicYearLoaded extends AcademicYearState {
  final List<AcademicYearModel> tutorList;

  AcademicYearLoaded(this.tutorList);

  @override
  List<Object?> get props => [tutorList];
}

class AcademicYearError extends AcademicYearState {
  final String error;

  AcademicYearError(this.error);

  @override
  List<Object?> get props => [error];
}
