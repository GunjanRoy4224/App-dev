import 'package:flutter/material.dart';
import '../../models/exam_timetable_model.dart';
import '../../services/exam_timetable_service.dart';
import '../../utils/exam_grouping.dart';

class ExamTimetableScreen extends StatefulWidget {
  const ExamTimetableScreen({super.key});

  @override
  State<ExamTimetableScreen> createState() => _ExamTimetableScreenState();
}

class _ExamTimetableScreenState extends State<ExamTimetableScreen> {
  final ExamTimetableService _service = ExamTimetableService();
  ExamTimetable? timetable;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    timetable = await _service.fetchExamTimetable();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (timetable == null) {
      return const Center(
        child: Text(
          "Exam timetable not announced yet",
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    final grouped = groupByDate(timetable!.entries);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          timetable!.title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        ...grouped.entries.map((group) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${group.key} (${group.value.first.day})",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),

              ...group.value.map((e) => Card(
                    child: ListTile(
                      title: Text("${e.course} • Slot ${e.slot}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Time: ${e.time}"),
                          Text("Instructor: ${e.instructor}"),
                          if (e.venue.isNotEmpty)
                            Text("Venue: ${e.venue}"),
                        ],
                      ),
                    ),
                  )),
              const SizedBox(height: 16),
            ],
          );
        }),
      ],
    );
  }
}
