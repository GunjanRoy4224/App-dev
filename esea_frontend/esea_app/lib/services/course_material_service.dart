import 'package:dio/dio.dart';
import '../models/course_material_model.dart';
import '../constants/api_constants.dart';
import 'dio_client.dart';

class CourseMaterialService {
  final Dio _dio = DioClient().dio;

  Future<List<CourseMaterial>> fetchAllCourses() async {
    try {
  final response = await _dio.get(ApiConstants.courseMaterials);
  return (response.data as List)
      .map((e) => CourseMaterial.fromJson(e))
      .toList();
} catch (e) {
  print("COURSE MATERIAL API ERROR: $e");
  rethrow;
}
}

  Future<CourseMaterial> fetchCourse(String courseCode) async {
    final response = await _dio.get(
      '${ApiConstants.courseMaterials}/$courseCode',
    );
    print("REQUEST URL = ${ApiConstants.courseMaterials}");

    return CourseMaterial.fromJson(response.data);
  }
}
