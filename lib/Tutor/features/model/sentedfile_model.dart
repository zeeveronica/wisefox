class StudentListModel {
  final int id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String phoneNumber;
  final String dateOfBirth;
  final String gender;
  final int year;
  final String skill;
  final String country;
  final List<dynamic> subject;
  final String studentPhoto;
  final int client;
  final String clientUsername;
  final bool isActive;
  final String lastLogin;
  final String createdDate;
  final String fullName;
  String activeChoices;

  StudentListModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.gender,
    required this.year,
    required this.skill,
    required this.country,
    required this.subject,
    required this.studentPhoto,
    required this.client,
    required this.clientUsername,
    required this.isActive,
    required this.lastLogin,
    required this.createdDate,
    required this.fullName,
    required this.activeChoices,
  });

  factory StudentListModel.fromJson(Map<String, dynamic> json) {
    return StudentListModel(
      id: json['id'] ?? 0,
      firstName: json['first_name']?.toString() ?? '',
      lastName: json['last_name']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phoneNumber:
          json['phonenumber']?.toString() ?? '', // Ensure string conversion
      dateOfBirth: json['date_of_birth']?.toString() ?? '', // Convert to string
      gender: json['gender']?.toString() ?? '',
      year: json['year'] ?? 0, // Keeping 'year' as an integer
      skill: json['skill']?.toString() ?? '',
      country: json['country']?.toString() ?? '',
      subject: json['subject'] ?? [], // Default to an empty list if null
      studentPhoto: json['student_photo']?.toString() ?? '',
      client: json['client'] ?? 0,
      clientUsername: json['client_username']?.toString() ?? '',
      isActive: json['is_active'] ?? false,
      lastLogin: json['last_login']?.toString() ??
          '', // Convert to string if necessary
      createdDate: json['created_date']?.toString() ?? '', // Convert to string
      fullName: json['full_name']?.toString() ?? '',
      activeChoices: json['active_choices']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'username': username,
      'email': email,
      'phonenumber': phoneNumber,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'year': year,
      'skill': skill,
      'country': country,
      'subject': subject,
      'student_photo': studentPhoto,
      'client': client,
      'client_username': clientUsername,
      'is_active': isActive,
      'last_login': lastLogin,
      'created_date': createdDate,
      'full_name': fullName,
      'active_choices': activeChoices,
    };
  }
}
