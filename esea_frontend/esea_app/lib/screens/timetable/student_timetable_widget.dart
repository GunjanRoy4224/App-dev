import 'package:flutter/material.dart';
import '../../models/student_timetable_entry.dart';
import '../../services/dio_client.dart';
import '../../constants/api_constants.dart';
import '../../widgets/student_weekly_timetable_grid.dart';
import '../../widgets/course_selector_sheet.dart';

class StudentTimetableWidget extends StatefulWidget {
  const StudentTimetableWidget({super.key});

  @override
  State<StudentTimetableWidget> createState() =>
      _StudentTimetableWidgetState();
}

class _StudentTimetableWidgetState extends State<StudentTimetableWidget> {
  bool loading = true;
  String? error;

  List<StudentTimetableEntry> entries = [];
  List<String> selectedCourses = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      final dio = DioClient().dio;

      // 1️⃣ GET selected courses (TRAILING SLASH REQUIRED)
      final scRes = await dio.get("/student/courses/");
      selectedCourses = (scRes.data as List)
          .map((e) => e['course_code'].toString())
          .toList();

      // If no courses selected → stop here
      if (selectedCourses.isEmpty) {
        entries = [];
        loading = false;
        setState(() {});
        return;
      }

      // 2️⃣ GET department courses
      final deptRes =
          await dio.get(ApiConstants.departmentCourses);

      // course_code -> slot_code (e.g. "11A, 11B")
      final Map<String, String> courseToSlot = {};

      (deptRes.data as Map<String, dynamic>).forEach((_, list) {
        for (final c in list) {
          final code = c['course_code']?.toString();
          final slot = c['slot_code']?.toString();

          if (code != null &&
              slot != null &&
              selectedCourses.contains(code)) {
            courseToSlot[code] = slot;
          }
        }
      });

      // 3️⃣ GET slot-time map (CORRECT PATH)
      final slotRes =
          await dio.get(ApiConstants.slotTimeMap);

      final List<StudentTimetableEntry> temp = [];

      // 🔥 CRITICAL FIX: SPLIT MULTI-SLOT COURSES
      for (final entry in courseToSlot.entries) {
        final slotCodes = entry.value
            .split(',')
            .map((s) => s.trim())
            .toList();

        for (final slot in slotRes.data) {
          if (slotCodes.contains(slot['slot_code'])) {
            temp.add(
              StudentTimetableEntry(
                courseCode: entry.key,
                day: slot['day'],
                startTime: slot['start_time'],
                endTime: slot['end_time'],
              ),
            );
          }
        }
      }

      entries = temp;
    } catch (e) {
      error = e.toString();
    }

    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.edit),
          label: const Text("Select / Edit Courses"),
          onPressed: () async {
            await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) => CourseSelectorSheet(
                selectedCourses: selectedCourses,
                onUpdated: () async {
                  await _load();
                },
              ),
            );
          },
        ),

        const SizedBox(height: 8),

        if (error != null)
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              error!,
              style: const TextStyle(color: Colors.red),
            ),
          )
        else if (entries.isEmpty)
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text("No courses selected"),
          )
        else
          StudentWeeklyTimetableGrid(entries: entries),
      ],
    );
  }
}
