class DashboardModel {
  final int allocatedStudents;
  final int activeAllocations;
  final int cancelledAllocations;
  final int weeklyTuitionHrs;
  final int todayScheduledLesson;
  final int upcomingLesson;
  final int todayCompletedLesson;
  final int demoClasses;
  final int clientStudents;
  final int clientTutors;
  final int completedLesson;
  final int studentAbsent;
  final int tutorAbsent;
  final int cancelledLessons;
  final double rechargeTillDate;
  final double balanceCredits;

  DashboardModel({
    required this.allocatedStudents,
    required this.activeAllocations,
    required this.cancelledAllocations,
    required this.weeklyTuitionHrs,
    required this.todayScheduledLesson,
    required this.upcomingLesson,
    required this.todayCompletedLesson,
    required this.demoClasses,
    required this.clientStudents,
    required this.clientTutors,
    required this.completedLesson,
    required this.studentAbsent,
    required this.tutorAbsent,
    required this.cancelledLessons,
    required this.rechargeTillDate,
    required this.balanceCredits,
  });

  // Factory method to parse JSON data
  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      allocatedStudents: json['allocated_students'] ?? 0,
      activeAllocations: json['active_allocations'] ?? 0,
      cancelledAllocations: json['cancelled_allocations'] ?? 0,
      weeklyTuitionHrs: json['weekly_tuition_hrs'] ?? 0,
      todayScheduledLesson: json['today_scheduled_lesson'] ?? 0,
      upcomingLesson: json['upcoming_lesson'] ?? 0,
      todayCompletedLesson: json['today_completed_lesson'] ?? 0,
      demoClasses: json['demo_classes'] ?? 0,
      clientStudents: json['client_students'] ?? 0,
      clientTutors: json['client_tutors'] ?? 0,
      completedLesson: json['completed_lesson'] ?? 0,
      studentAbsent: json['student_absent'] ?? 0,
      tutorAbsent: json['tutor_absent'] ?? 0,
      cancelledLessons: json['cancelled_lessons'] ?? 0,
      rechargeTillDate: json['recharge_till_date']?.toDouble() ?? 0.0,
      balanceCredits: json['balance_credits']?.toDouble() ?? 0.0,
    );
  }

  // Method to convert object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'allocated_students': allocatedStudents,
      'active_allocations': activeAllocations,
      'cancelled_allocations': cancelledAllocations,
      'weekly_tuition_hrs': weeklyTuitionHrs,
      'today_scheduled_lesson': todayScheduledLesson,
      'upcoming_lesson': upcomingLesson,
      'today_completed_lesson': todayCompletedLesson,
      'demo_classes': demoClasses,
      'client_students': clientStudents,
      'client_tutors': clientTutors,
      'completed_lesson': completedLesson,
      'student_absent': studentAbsent,
      'tutor_absent': tutorAbsent,
      'cancelled_lessons': cancelledLessons,
      'recharge_till_date': rechargeTillDate,
      'balance_credits': balanceCredits,
    };
  }
}
