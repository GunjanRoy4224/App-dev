import 'package:flutter/material.dart';
import '../../services/exam_timetable_service.dart';
import '../../models/exam_timetable_model.dart'; // ✅ REQUIRED

class ExamTimetableWidget extends StatefulWidget {
  const ExamTimetableWidget({super.key});

  @override
  State<ExamTimetableWidget> createState() => _ExamTimetableWidgetState();
}

class _ExamTimetableWidgetState extends State<ExamTimetableWidget> {
  ExamTimetable? timetable; // ✅ NOW FOUND
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final data = await ExamTimetableService().fetchExamTimetable();
    setState(() {
      timetable = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (timetable == null) {
      return const Center(
        child: Text(
          "Exam timetable not announced yet",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    // group by date
    final Map<String, List<ExamEntry>> grouped = {};
    for (final e in timetable!.entries) {
      grouped.putIfAbsent(e.date, () => []);
      grouped[e.date]!.add(e);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          timetable!.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...grouped.entries.map(
          (entry) => _dateSection(entry.key, entry.value),
        ),
      ],
    );
  }

  Widget _dateSection(String date, List<ExamEntry> exams) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$date (${exams[0].day})",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            ...exams.map(_examRow),
          ],
        ),
      ),
    );
  }

  Widget _examRow(ExamEntry e) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            e.course,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Text("Time: ${e.time}"),
          if (e.slot != null) Text("Slot: ${e.slot}"),
          if (e.instructor != null) Text("Instructor: ${e.instructor}"),
          if (e.venue != null) Text("Venue: ${e.venue}"),
          if (e.enrolment != null) Text("Enrolment: ${e.enrolment}"),
        ],
      ),
    );
  }
}
