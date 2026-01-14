class ApiConstants {
  // static const String baseUrl = "http://10.0.2.2:8000/api";

  // Auth
  static const String ssoLogin = "/auth/sso/login";
  static const String me = "/users/me";

  // Content
  static String contentByType(String type) => "/content/$type";

  // Timetable
  static const String slotTimeMap = "/timetable/slots";
  static const String departmentCourses = "/timetable/department";
  static const String studentTimetable = "/timetable/student/";


  // Exams
  static const String examTimetable = "/timetable/exams";

  // Course Material
  static const String courseMaterials = "/course-materials/";
}
