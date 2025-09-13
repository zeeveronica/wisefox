// // class StudentModel {
// //   final int id;
// //   final String firstName;
// //   final String lastName;
// //   final String username;
// //   final String email;
// //   final String phonenumber;
// //   final String dateOfBirth;
// //   final String gender;
// //   final String country;
// //   final String studentPhoto;
// //   final int client;
// //   final String clientUsername;
// //   final bool isActive;
//
// //   StudentModel({
// //     required this.id,
// //     required this.firstName,
// //     required this.lastName,
// //     required this.username,
// //     required this.email,
// //     required this.phonenumber,
// //     required this.dateOfBirth,
// //     required this.gender,
// //     required this.country,
// //     required this.studentPhoto,
// //     required this.client,
// //     required this.clientUsername,
// //     required this.isActive,
// //   });
//
// //   factory StudentModel.fromJson(Map<String, dynamic> json) {
// //     return StudentModel(
// //       id: json['id'],
// //       firstName: json['first_name'],
// //       lastName: json['last_name'],
// //       username: json['username'],
// //       email: json['email'],
// //       phonenumber: json['phonenumber'],
// //       dateOfBirth: json['date_of_birth'],
// //       gender: json['gender'],
// //       country: json['country'],
// //       studentPhoto: json['student_photo'],
// //       client: json['client'],
// //       clientUsername: json['client_username'],
// //       isActive: json['is_active'],
// //     );
// //   }
// // }
// class StudentModel {
//   final int id;
//   final String firstName;
//   final String lastName;
//   final String username;
//   final String email;
//   final String phonenumber;
//   final String dateOfBirth;
//   final String gender;
//   final String country;
//   final String studentPhoto;
//   final int client;
//   final String clientUsername;
//   final bool isActive;
//
//   StudentModel({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.username,
//     required this.email,
//     required this.phonenumber,
//     required this.dateOfBirth,
//     required this.gender,
//     required this.country,
//     required this.studentPhoto,
//     required this.client,
//     required this.clientUsername,
//     required this.isActive,
//   });
//
//   factory StudentModel.fromJson(Map<String, dynamic> json) {
//     return StudentModel(
//       id: json['id'],
//       firstName: json['first_name'],
//       lastName: json['last_name'],
//       username: json['username'],
//       email: json['email'],
//       phonenumber: json['phonenumber'],
//       dateOfBirth: json['date_of_birth'],
//       gender: json['gender'],
//       country: json['country'],
//       studentPhoto: json['student_photo'],
//       client: json['client'],
//       clientUsername: json['client_username'],
//       isActive: json['is_active'],
//     );
//   }
//
//   @override
//   String toString() {
//     return 'StudentModel(id: $id, firstName: $firstName, lastName: $lastName, username: $username, email: $email, phonenumber: $phonenumber, dateOfBirth: $dateOfBirth, gender: $gender, country: $country, studentPhoto: $studentPhoto, client: $client, clientUsername: $clientUsername, isActive: $isActive)';
//   }
// }


class StudentModel {
  final int id;
  final int? studentId;
  final int? tutorId;
  final int? clientId;
  final String username;
  final String firstName;
  final String lastName;
  final String? email;
  final String? phonenumber;
  final String? profilePhoto;
  final bool isActive;
  final bool isVerified;
  final String? userTypes;
  final String? activeChoices;
  final String? referralCode;

  StudentModel({
    required this.id,
    this.studentId,
    this.tutorId,
    this.clientId,
    required this.username,
    required this.firstName,
    required this.lastName,
    this.email,
    this.phonenumber,
    this.profilePhoto,
    required this.isActive,
    required this.isVerified,
    this.userTypes,
    this.activeChoices,
    this.referralCode,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'],
      studentId: json['student_id'],
      tutorId: json['tutor_id'],
      clientId: json['client_id'],
      username: json['username'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'],
      phonenumber: json['phonenumber'],
      profilePhoto: json['profile_photo'] ?? json['student_photo'],
      isActive: json['is_active'] ?? false,
      isVerified: json['is_verified'] ?? false, // 👈 fix here
      userTypes: json['user_types'],
      activeChoices: json['active_choices'],
      referralCode: json['referral_code'],
    );
  }


  // factory StudentModel.fromJson(Map<String, dynamic> json) {
  //   return StudentModel(
  //     id: json['id'],
  //     studentId: json['student_id'],
  //     tutorId: json['tutor_id'],
  //     clientId: json['client_id'],
  //     username: json['username'],
  //     firstName: json['first_name'],
  //     lastName: json['last_name'],
  //     email: json['email'],
  //     phonenumber: json['phonenumber'],
  //     profilePhoto: json['profile_photo'],
  //     isActive: json['is_active'],
  //     isVerified: json['is_verified'],
  //     userTypes: json['user_types'],
  //     activeChoices: json['active_choices'],
  //     referralCode: json['referral_code'],
  //   );
  // }

  /// ✅ Convert model back to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_id': studentId,
      'tutor_id': tutorId,
      'client_id': clientId,
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phonenumber': phonenumber,
      'profile_photo': profilePhoto,
      'is_active': isActive,
      'is_verified': isVerified,
      'user_types': userTypes,
      'active_choices': activeChoices,
      'referral_code': referralCode,
    };
  }

}

