import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeeklyTimetableGrid extends StatelessWidget {
  final Map<String, dynamic> timetable;

  const WeeklyTimetableGrid({super.key, required this.timetable});

  static const days = ["Mon", "Tue", "Wed", "Thu", "Fri"];

  String _today() => DateFormat('EEE').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final today = _today();

    // Collect time slots
    final Set<String> times = {};
    for (final dayCourses in timetable.values) {
      if (dayCourses is List) {
        for (final c in dayCourses) {
          times.add("${c["start_time"]}-${c["end_time"]}");
        }
      }
    }
    final timeSlots = times.toList()..sort();

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------------- FIXED DAY COLUMN ----------------
          Column(
            children: [
              _headerCell("Day", width: 70),
              ...days.map(
                (d) => _dayCell(
                  d,
                  highlight: d == today,
                ),
              ),
            ],
          ),

          // ---------------- SCROLLABLE TIMETABLE ----------------
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _timeHeaderRow(timeSlots),
                  ...days.map(
                    (d) => _timeRow(
                      d,
                      timeSlots,
                      highlight: d == today,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- HEADERS ----------------

  Widget _timeHeaderRow(List<String> times) {
    return Row(
      children: times.map((t) => _headerCell(t)).toList(),
    );
  }

  // ---------------- ROWS ----------------

  Widget _timeRow(String day, List<String> times, {bool highlight = false}) {
    final List courses =
        timetable[day] is List ? timetable[day] : [];

    return Row(
      children: times.map((time) {
        final cellCourses = courses
            .where((c) =>
                "${c["start_time"]}-${c["end_time"]}" == time)
            .toList();

        return _courseCell(
          cellCourses,
          highlight: highlight,
        );
      }).toList(),
    );
  }

  // ---------------- CELLS ----------------

  Widget _headerCell(String text, {double width = 140}) {
    return Container(
      width: width,
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border.all(color: Colors.black12),
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _dayCell(String day, {bool highlight = false}) {
    return Container(
      width: 70,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: highlight ? Colors.yellow.shade100 : Colors.white,
        border: Border.all(color: Colors.black12),
      ),
      child: Text(
        day,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _courseCell(List courses, {bool highlight = false}) {
    return Container(
      width: 140,
      height: 70,
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: highlight ? Colors.yellow.shade50 : Colors.white,
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: courses.map<Widget>((c) {
          return Text(
            c["course_code"],
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          );
        }).toList(),
      ),
    );
  }
}
