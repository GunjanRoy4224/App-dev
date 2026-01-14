class RunningCourse {
  final String courseCode;
  final String slotCode;
  final String credits;
  final String courseTitle;
  final String instructor;
  final String classroom;
  final String tag;
  final String programme;

  RunningCourse({
    required this.courseCode,
    required this.slotCode,
    required this.credits,
    required this.courseTitle,
    required this.instructor,
    required this.classroom,
    required this.tag,
    required this.programme,
  });

  factory RunningCourse.fromJson(Map<String, dynamic> json) {
    return RunningCourse(
      courseCode: (json['course_code'] ?? '').toString(),
      slotCode: (json['slot_code'] ?? '').toString(),
      credits: (json['credit'] ?? '').toString(),
      courseTitle: (json['course_title'] ?? '').toString(),
      instructor: (json['instructors'] ?? '').toString(),
      classroom: (json['classroom'] ?? '').toString(),
      tag: (json['tag'] ?? '').toString(),
      programme: (json['programme'] ?? '').toString(), // ✅ FIX
    );
  }
}
