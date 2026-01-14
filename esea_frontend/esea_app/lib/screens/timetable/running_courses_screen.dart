import 'package:flutter/material.dart';
import '../../services/dio_client.dart';
import '../../constants/api_constants.dart';
import '../../models/running_course_model.dart';
import 'running_courses_widget.dart';

class RunningCoursesScreen extends StatefulWidget {
  const RunningCoursesScreen({super.key});

  @override
  State<RunningCoursesScreen> createState() =>
      _RunningCoursesScreenState();
}

class _RunningCoursesScreenState extends State<RunningCoursesScreen> {
  List<RunningCourse> courses = [];
  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final res =
          await DioClient().dio.get(ApiConstants.departmentCourses);

      final Map<String, dynamic> data = res.data;
      final List<RunningCourse> temp = [];

      data.forEach((_, list) {
        for (final e in list) {
          temp.add(RunningCourse.fromJson(e));
        }
      });

      courses = temp;
    } catch (e) {
      error = e.toString();
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Text(
        "Failed to load running courses:\n$error",
        style: const TextStyle(color: Colors.red),
      );
    }

    return RunningCoursesWidget(courses: courses);
  }
}
