class TutorDetails {
  final int id;
  final String name;
  final String firstName;
  final String lastName;
  final String userName;
  final String dateOfBirth;
  final String phonenumber;
  final String email;
  final String gender;
  final String addressLine;
  final String townOrCity;
  final String country;
  final String postCode;
  final String state;
  final String? tutorPhoto;
  final bool isActive;
  final String activeChoices;
  final List<QualificationDetails> qualificationDetails;
  final List<TeachingSkillDetails> teachingSkillDetails;
  final List<TutorRateDetails> tutorRateDetails;
  final List<Availability> availabilities;
  final String createdDate;
  final String lastLogin;

  TutorDetails({
    required this.id,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.dateOfBirth,
    required this.phonenumber,
    required this.email,
    required this.gender,
    required this.addressLine,
    required this.townOrCity,
    required this.country,
    required this.postCode,
    required this.state,
    this.tutorPhoto,
    required this.isActive,
    required this.activeChoices,
    required this.qualificationDetails,
    required this.teachingSkillDetails,
    required this.tutorRateDetails,
    required this.availabilities,
    required this.createdDate,
    required this.lastLogin,
  });

  factory TutorDetails.fromJson(Map<String, dynamic> json) {
    return TutorDetails(
      id: json['id'],
      name: json['name'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      userName: json['user_name'],
      dateOfBirth: json['date_of_birth'],
      phonenumber: json['phonenumber'],
      email: json['email'],
      gender: json['gender'],
      addressLine: json['address_line'],
      townOrCity: json['town_or_city'],
      country: json['country'],
      postCode: json['post_code'],
      state: json['state'],
      tutorPhoto: json['tutor_photo'],
      isActive: json['is_active'],
      activeChoices: json['active_choices'],
      qualificationDetails: (json['qualification_details'] as List)
          .map((item) => QualificationDetails.fromJson(item))
          .toList(),
      teachingSkillDetails: (json['teaching_skill_details'] as List)
          .map((item) => TeachingSkillDetails.fromJson(item))
          .toList(),
      tutorRateDetails: (json['tutor_rate_details'] as List)
          .map((item) => TutorRateDetails.fromJson(item))
          .toList(),
      availabilities: (json['availablities'] as List)
          .map((item) => Availability.fromJson(item))
          .toList(),
      createdDate: json['created_date'],
      lastLogin: json['last_login'],
    );
  }
}

class QualificationDetails {
  final int id;
  final String qualificationLevel;
  final String school;
  final String nameOfInstitute;
  final String fieldOfStudy;
  final int startYear;
  final int endYear;
  final String proof;

  QualificationDetails({
    required this.id,
    required this.qualificationLevel,
    required this.school,
    required this.nameOfInstitute,
    required this.fieldOfStudy,
    required this.startYear,
    required this.endYear,
    required this.proof,
  });

  factory QualificationDetails.fromJson(Map<String, dynamic> json) {
    return QualificationDetails(
      id: json['id'],
      qualificationLevel: json['qualification_level'],
      school: json['school'],
      nameOfInstitute: json['name_of_institute'],
      fieldOfStudy: json['field_of_study'],
      startYear: json['start_year'],
      endYear: json['end_year'],
      proof: json['proof'],
    );
  }
}

class TeachingSkillDetails {
  final int id;
  final int subject;
  final String subjectName;
  final int yearToTeach;
  final String skill;

  TeachingSkillDetails({
    required this.id,
    required this.subject,
    required this.subjectName,
    required this.yearToTeach,
    required this.skill,
  });

  factory TeachingSkillDetails.fromJson(Map<String, dynamic> json) {
    return TeachingSkillDetails(
      id: json['id'],
      subject: json['subject'],
      subjectName: json['subject_name'],
      yearToTeach: json['year_to_teach'],
      skill: json['skill'],
    );
  }
}

class TutorRateDetails {
  final int id;
  final String tutorRate;
  final String clientRate;
  final List<Skill> skills;

  TutorRateDetails({
    required this.id,
    required this.tutorRate,
    required this.clientRate,
    required this.skills,
  });

  factory TutorRateDetails.fromJson(Map<String, dynamic> json) {
    return TutorRateDetails(
      id: json['id'],
      tutorRate: json['tutor_rate'],
      clientRate: json['client_rate'],
      skills:
          (json['skills'] as List).map((item) => Skill.fromJson(item)).toList(),
    );
  }
}

class Skill {
  final int id;
  final String name;

  Skill({
    required this.id,
    required this.name,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Availability {
  final String day;
  final List<TimeSlot> timeSlots;

  Availability({
    required this.day,
    required this.timeSlots,
  });

  factory Availability.fromJson(Map<String, dynamic> json) {
    return Availability(
      day: json['day'],
      timeSlots: (json['time_slots'] as List)
          .map((item) => TimeSlot.fromJson(item))
          .toList(),
    );
  }
}

class TimeSlot {
  final int id;
  final String startTime;
  final bool isFilled;

  TimeSlot({
    required this.id,
    required this.startTime,
    required this.isFilled,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      id: json['id'],
      startTime: json['start_time'],
      isFilled: json['is_filled'],
    );
  }
}
