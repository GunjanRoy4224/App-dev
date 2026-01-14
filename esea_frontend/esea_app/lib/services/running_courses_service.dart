import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import '../models/running_course_model.dart';
import 'dio_client.dart';

class RunningCoursesService {
  final Dio _dio = DioClient().dio;

  Future<List<RunningCourse>> fetchRunningCourses() async {
    final res = await _dio.get(ApiConstants.departmentCourses);

    return (res.data as List)
        .map((e) => RunningCourse.fromJson(e))
        .toList();
  }
}
