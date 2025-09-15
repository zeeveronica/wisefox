part of 'studentadmission_bloc.dart';

abstract class StudentAdmissionState extends Equatable {
  const StudentAdmissionState();

  @override
  List<Object> get props => [];
}

class StudentAdmissionInitial extends StudentAdmissionState {}

class StudentAdmissionLoading extends StudentAdmissionState {}

class StudentAdmissionSuccess extends StudentAdmissionState {}

class StudentAdmissionFailure extends StudentAdmissionState {
  final String error;

  const StudentAdmissionFailure({required this.error});

  @override
  List<Object> get props => [error];
}
