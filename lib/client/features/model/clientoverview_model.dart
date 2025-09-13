class ClientOverviewCount {
  final int lessonToday;
  final int upcomingLesson;
  final int activeAllocations;
  final int cancelledAllocations;
  final int allocatedTutors;
  final int weeklyHours;
  final int completedLessons;
  final int studentAbsentLessons;
  final int demoLessons;
  final int activeLessons;
  final int cancelledLessons;

  ClientOverviewCount({
    required this.lessonToday,
    required this.upcomingLesson,
    required this.activeAllocations,
    required this.cancelledAllocations,
    required this.allocatedTutors,
    required this.weeklyHours,
    required this.completedLessons,
    required this.studentAbsentLessons,
    required this.demoLessons,
    required this.activeLessons,
    required this.cancelledLessons,
  });

  factory ClientOverviewCount.fromJson(Map<String, dynamic> json) {
    return ClientOverviewCount(
      lessonToday: json['lesson_today'] ?? 0,
      upcomingLesson: json['upcoming_lesson'] ?? 0,
      activeAllocations: json['active_allocations'] ?? 0,
      cancelledAllocations: json['cancelled_allocations'] ?? 0,
      allocatedTutors: json['allocated_tutors'] ?? 0,
      weeklyHours: json['weekly_hours'] ?? 0,
      completedLessons: json['completed_lessons'] ?? 0,
      studentAbsentLessons: json['student_absent_lessons'] ?? 0,
      demoLessons: json['demolessons'] ?? 0,
      activeLessons: json['active_lessons'] ?? 0,
      cancelledLessons: json['cancelled_lessons'] ?? 0,
    );
  }
}
