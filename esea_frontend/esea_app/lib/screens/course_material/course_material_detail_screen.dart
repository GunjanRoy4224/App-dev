import 'package:flutter/material.dart';
import '../../models/course_material_model.dart';


class CourseMaterialDetailScreen extends StatelessWidget {
  final CourseMaterial course;

  const CourseMaterialDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final views = <Widget>[];

    if (course.lectures.isNotEmpty) {
      views.add(_section('Lectures', course.lectures));
    }
    if (course.resources.isNotEmpty) {
      views.add(_section('Resources', course.resources));
    }
    if (course.pyqs.isNotEmpty) {
      views.add(_section('PYQs', course.pyqs));
    }

    return Scaffold(
      appBar: AppBar(title: Text(course.courseCode)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: views,
      ),
    );
  }

  Widget _section(String title, List<ResourceItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(height: 8),
        ...items.map(
          (e) => ListTile(
            title: Text(e.title),
            trailing: const Icon(Icons.open_in_new),
            onTap: () {
              // open e.link (url_launcher)
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
