import 'package:flutter/material.dart';
import 'department_timetable_widget.dart';
import 'student_timetable_widget.dart';
import 'exam_timetable_widget.dart';
import 'running_courses_screen.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  bool showExam = false;
  bool showRunning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Timetable")),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const Text(
            "Department Timetable",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const DepartmentTimetableWidget(),

          const SizedBox(height: 24),
          const Text(
            "My Timetable",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          /// 🔥 STUDENT TIMETABLE (NOW ACTUALLY LOADS)
          const StudentTimetableWidget(),

          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showExam = !showExam;
                      showRunning = false;
                    });
                  },
                  child: const Text("Exam Timetable"),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showRunning = !showRunning;
                      showExam = false;
                    });
                  },
                  child: const Text("Running Courses"),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          if (showExam) const ExamTimetableWidget(),

          /// 🔥 USE SCREEN, NOT WIDGET
          if (showRunning) const RunningCoursesScreen(),
        ],
      ),
    );
  }
}
