import 'package:flutter/material.dart';
import '../../models/course_material_model.dart';
import '../../services/course_material_service.dart';
import './course_material_detail_screen.dart';

class CourseMaterialListScreen extends StatefulWidget {
  const CourseMaterialListScreen({super.key});

  @override
  State<CourseMaterialListScreen> createState() =>
      _CourseMaterialListScreenState();
}

class _CourseMaterialListScreenState
    extends State<CourseMaterialListScreen> {
  final CourseMaterialService _service = CourseMaterialService();

  List<CourseMaterial> courses = [];
  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
  try {
    setState(() {
      loading = true;
      error = null;
    });

    courses = await _service.fetchAllCourses();
    debugPrint("Courses loaded: ${courses.length}");
  } catch (e) {
    error = "Failed to load course materials";
    debugPrint("COURSE LOAD ERROR: $e");
  } finally {
    if (mounted) {
      setState(() => loading = false);
    }
  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Course Materials"),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(child: Text(error!))
              : courses.isEmpty
                  ? const Center(
                      child: Text("No course materials available"),
                    )
                  : ListView.builder(
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        final c = courses[index];

                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: ListTile(
                            title: Text(
                              c.courseCode,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text(c.courseTitle),
                                const SizedBox(height: 2),
                                Text(
                                 "Prof. ${c.instructor ?? 'N/A'}",
                                  style: const TextStyle(fontSize: 12),
                                   ),
                              ],
                            ),
                            trailing:
                                const Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      CourseMaterialDetailScreen(course: c),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
    );
  }
}
