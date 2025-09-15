class Tutor {
  final int id;
  final String userName;
  final String email;
  final String? country; // Make country nullable
  final String phonenumber;
  final String? gender;
  final int? studentCount;
  final bool isActive;
  final String? photo; // Nullable
  // final String? fullName;

  Tutor({
    required this.id,
    required this.userName,
    required this.email,
    this.country, // Nullable field
    required this.phonenumber,
    this.gender,
    this.studentCount,
    required this.isActive,
    this.photo, // Nullable field
    // this.fullName,
  });

  factory Tutor.fromJson(Map<String, dynamic> json) {
    return Tutor(
      id: json['id'],
      userName: json['username'] ?? '-',
      email: json['email'] ?? '-',
      country: json['country']?.toString() ?? "-", // Safely convert country to string
      phonenumber: json['phonenumber'] ?? "-",
      gender: json['gender'] ?? '-',
      studentCount: json['student_count'] ?? 0,
      isActive: json['is_active'],
      photo: json['profile_photo'] as String? ?? "-", // Nullable String
      // fullName: json['name'] as String, // Ensure not null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_name': userName,
      'email': email,
      'country': country ?? '', // Provide default if null
      'phonenumber': phonenumber,
      'gender': gender,
      'student_count': studentCount,
      'is_active': isActive,
      'profile_photo': photo ?? '', // Provide default if null
      // 'name': fullName,
    };
  }
}
