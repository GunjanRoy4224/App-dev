import '../services/dio_client.dart';

class StudentCourseService {
  get _dio => DioClient().dio;

  Future<List<String>> getSelectedCourses() async {
    final res = await _dio.get("/student/courses/");
    return (res.data as List)
        .map((e) => e['course_code'].toString())
        .toList();
  }

  Future<void> addCourse(String courseCode) async {
    await _dio.post(
      "/student/courses/",
      data: {"course_code": courseCode},
    );
  }

  Future<void> removeCourse(String courseCode) async {
    await _dio.delete("/student/courses/$courseCode");
  }
}
