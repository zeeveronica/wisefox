class StudentModel {
  final int id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String phonenumber;
  final String dateOfBirth;
  final String gender;
  final String country;
  final String studentPhoto;
  final int client;
  final String clientUsername;
  final bool isActive;

  StudentModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phonenumber,
    required this.dateOfBirth,
    required this.gender,
    required this.country,
    required this.studentPhoto,
    required this.client,
    required this.clientUsername,
    required this.isActive,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'] ?? 0, // Default to 0 if id is null
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      phonenumber: json['phonenumber'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      gender: json['gender'] ?? '',
      country: json['country'] ?? '',
      studentPhoto: json['student_photo'] ?? '',
      client: json['client'] ?? 0,
      clientUsername: json['client_username'] ?? '',
      isActive: json['is_active'] ?? false,
    );
  }

  @override
  String toString() {
    return 'StudentModel(id: $id, firstName: $firstName, lastName: $lastName, username: $username, email: $email, phonenumber: $phonenumber, dateOfBirth: $dateOfBirth, gender: $gender, country: $country, studentPhoto: $studentPhoto, client: $client, clientUsername: $clientUsername, isActive: $isActive)';
  }
}
