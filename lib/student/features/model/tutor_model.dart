class Tutor {
  final int id;
  final String userName;
  final String email;
  final String country;
  final String phonenumber;
  final String gender;
  final int studentCount;
  final bool isActive;
  final String? photo; // Make photo nullable
  final String fullName;

  Tutor({
    required this.id,
    required this.userName,
    required this.email,
    required this.country,
    required this.phonenumber,
    required this.gender,
    required this.studentCount,
    required this.isActive,
    this.photo, // Optional field in the constructor
    required this.fullName,
  });

  factory Tutor.fromJson(Map<String, dynamic> json) {
    return Tutor(
      id: json['id'],
      userName: json['user_name'],
      email: json['email'],
      country: json['country'],
      phonenumber: json['phonenumber'],
      gender: json['gender'],
      studentCount: json['student_count'],
      isActive: json['is_active'],
      photo: json['tutor_photo'] as String?, // Handle nullable String
      fullName: json['full_name'] as String, // Ensure fullName is not null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_name': userName,
      'email': email,
      'country': country,
      'phonenumber': phonenumber,
      'gender': gender,
      'student_count': studentCount,
      'is_active': isActive,
      'tutor_photo': photo ?? '', // Provide default value if null
      'full_name': fullName,
    };
  }
}
