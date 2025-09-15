part of 'studentadmission_bloc.dart';

class StudentAdmissionEvent extends Equatable {
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String phoneNumber;
  final String dateOfBirth;
  final String gender;
  final String year;
  final String country;
  final List<Map<String, int>>
      subjects; // Ensure this is List<Map<String, int>>
  final String studentPhoto;

  const StudentAdmissionEvent({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.gender,
    required this.year,
    required this.country,
    required this.subjects,
    required this.studentPhoto,
  });

  @override
  List<Object> get props => [
        firstName,
        lastName,
        username,
        email,
        phoneNumber,
        dateOfBirth,
        gender,
        year,
        country,
        subjects,
        studentPhoto,
      ];
}
