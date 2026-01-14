import 'package:flutter/material.dart';
import '../../models/running_course_model.dart';

class RunningCoursesWidget extends StatelessWidget {
  final List<RunningCourse> courses;

  const RunningCoursesWidget({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    if (courses.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(12),
        child: Text("No running courses this semester"),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 18,
        columns: const [
          DataColumn(label: Text("Course")),
          DataColumn(label: Text("Title")),
          DataColumn(label: Text("Slot")),
          DataColumn(label: Text("Cr")),
          DataColumn(label: Text("Instructor")),
          DataColumn(label: Text("Room")),
          DataColumn(label: Text("Tag")),
          DataColumn(label: Text("programme")),
        ],
        rows: courses.map((c) {
          return DataRow(cells: [
            DataCell(Text(c.courseCode)),
            DataCell(Text(c.courseTitle)),
            DataCell(Text(c.slotCode)),     
            DataCell(Text(c.credits)),
            DataCell(Text(c.instructor)),
            DataCell(Text(c.classroom)),
            DataCell(Text(c.tag)),
            DataCell(Text(c.programme)),
          ]);
        }).toList(),
      ),
    );
  }
}
