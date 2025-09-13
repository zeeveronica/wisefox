class User {
  final int id; // general user id
  final int? studentId;
  final int? tutorId;
  final int? clientId;
  final int? affiliateId;
  final int? activeId; // automatically set based on user_type
  final String? email;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? userTypes;
  final String? profilePhoto;
  final String? phoneNumber;
  final bool isAdmin;
  final bool isActive;
  final bool isVerified;
  final bool isSuperuser;
  final bool isStaff;
  final String? activeChoices;
  final String? referralCode;
  final String? timezone;
  final String? token;
  final String? refresh;

  User({
    required this.id,
    this.studentId,
    this.tutorId,
    this.clientId,
    this.affiliateId,
    this.activeId,
    this.email,
    this.username,
    this.firstName,
    this.lastName,
    this.userTypes,
    this.profilePhoto,
    this.phoneNumber,
    this.isAdmin = false,
    this.isActive = true,
    this.isVerified = false,
    this.isSuperuser = false,
    this.isStaff = false,
    this.activeChoices,
    this.referralCode,
    this.timezone,
    this.token,
    this.refresh,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "student_id": studentId,
      "tutor_id": tutorId,
      "client_id": clientId,
      "affiliate_id": affiliateId,
      "activeId": activeId,
      "email": email,
      "username": username,
      "first_name": firstName,
      "last_name": lastName,
      "user_types": userTypes,
      "profile_photo": profilePhoto,
      "phonenumber": phoneNumber,
      "is_admin": isAdmin,
      "is_active": isActive,
      "is_verified": isVerified,
      "is_superuser": isSuperuser,
      "is_staff": isStaff,
      "active_choices": activeChoices,
      "referral_code": referralCode,
      "timezone": timezone,
      "token": token,
      "refresh": refresh,
    };
  }

  // Add this copyWith method
  User copyWith({
    int? id,
    int? studentId,
    int? tutorId,
    int? clientId,
    int? affiliateId,
    int? activeId,
    String? email,
    String? username,
    String? firstName,
    String? lastName,
    String? userTypes,
    String? profilePhoto,
    String? phoneNumber,
    bool? isAdmin,
    bool? isActive,
    bool? isVerified,
    bool? isSuperuser,
    bool? isStaff,
    String? activeChoices,
    String? referralCode,
    String? timezone,
    String? token,
    String? refresh,
  }) {
    return User(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      tutorId: tutorId ?? this.tutorId,
      clientId: clientId ?? this.clientId,
      affiliateId: affiliateId ?? this.affiliateId,
      activeId: activeId ?? this.activeId,
      email: email ?? this.email,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      userTypes: userTypes ?? this.userTypes,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isAdmin: isAdmin ?? this.isAdmin,
      isActive: isActive ?? this.isActive,
      isVerified: isVerified ?? this.isVerified,
      isSuperuser: isSuperuser ?? this.isSuperuser,
      isStaff: isStaff ?? this.isStaff,
      activeChoices: activeChoices ?? this.activeChoices,
      referralCode: referralCode ?? this.referralCode,
      timezone: timezone ?? this.timezone,
      token: token ?? this.token,
      refresh: refresh ?? this.refresh,
    );
  }

  factory User.fromJson(Map<String, dynamic> json, {Map<String, dynamic>? tokenData}) {
    // Determine activeId based on user_types
    int? activeId;
    final type = json['user_types'];
    if (type == 'Student') {
      activeId = json['student_id'];
    } else if (type == 'Tutor') {
      activeId = json['tutor_id'];
    } else if (type == 'Client') {
      activeId = json['client_id'];
    } else if (type == 'Affiliate') {
      activeId = json['affiliate_id'];
    }

    return User(
      id: json['id'],
      studentId: json['student_id'],
      tutorId: json['tutor_id'],
      clientId: json['client_id'],
      affiliateId: json['affiliate_id'],
      activeId: activeId,
      email: json['email'],
      username: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      userTypes: json['user_types'],
      profilePhoto: json['profile_photo'],
      phoneNumber: json['phonenumber'],
      isAdmin: json['is_admin'] ?? false,
      isActive: json['is_active'] ?? true,
      isVerified: json['is_verified'] ?? false,
      isSuperuser: json['is_superuser'] ?? false,
      isStaff: json['is_staff'] ?? false,
      activeChoices: json['active_choices'],
      referralCode: json['referral_code'],
      timezone: json['timezone'],
      token: tokenData?['token'],
      refresh: tokenData?['refresh'],
    );
  }
}
