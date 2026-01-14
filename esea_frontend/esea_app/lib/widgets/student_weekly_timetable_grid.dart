import 'package:flutter/material.dart';
import '../models/student_timetable_entry.dart';

class StudentWeeklyTimetableGrid extends StatelessWidget {
  final List<StudentTimetableEntry> entries;

  const StudentWeeklyTimetableGrid({super.key, required this.entries});

  static const days = ["Mon", "Tue", "Wed", "Thu", "Fri"];
  static const double slotHeight = 40;
  static const double dayWidth = 110;

  int _toMinutes(String time) {
    final p = time.split(":");
    return int.parse(p[0]) * 60 + int.parse(p[1]);
  }

  double _top(String start) {
    return (_toMinutes(start) - 8 * 60) / 30 * slotHeight;
  }

  double _height(String start, String end) {
    return (_toMinutes(end) - _toMinutes(start)) / 30 * slotHeight;
  }

  bool _hasConflict(
    StudentTimetableEntry a,
    List<StudentTimetableEntry> sameDay,
  ) {
    final aStart = _toMinutes(a.startTime);
    final aEnd = _toMinutes(a.endTime);

    for (final b in sameDay) {
      if (a == b) continue;

      final bStart = _toMinutes(b.startTime);
      final bEnd = _toMinutes(b.endTime);

      if (aStart < bEnd && bStart < aEnd) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final totalHeight = ((20 - 8) * 60 / 30) * slotHeight;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ================= TIME LABEL COLUMN =================
        Column(
          children: [
            _emptyHeader(),
            SizedBox(
              height: totalHeight,
              child: _timeLabels(),
            ),
          ],
        ),

        // ================= DAY COLUMNS =================
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: days.map((day) {
                final dayEntries =
                    entries.where((e) => e.day == day).toList();

                return SizedBox(
                  width: dayWidth,
                  child: Column(
                    children: [
                      _dayHeader(day),
                      SizedBox(
                        height: totalHeight,
                        child: Stack(
                          children: [
                            _timeGrid(),
                            ...dayEntries.map((e) {
                              final conflict =
                                  _hasConflict(e, dayEntries);

                              return Positioned(
                                top: _top(e.startTime),
                                left: 6,
                                right: 6,
                                height:
                                    _height(e.startTime, e.endTime),
                                child: _courseBlock(
                                  e,
                                  conflict: conflict,
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  // ================= UI PARTS =================

  Widget _emptyHeader() {
    return Container(
      height: 48,
      width: 60,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border.all(color: Colors.black12),
      ),
    );
  }

  Widget _dayHeader(String day) {
    return Container(
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border.all(color: Colors.black12),
      ),
      child: Text(day, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _timeLabels() {
    return Column(
      children: List.generate((20 - 8) * 2 + 1, (i) {
        final minutes = 8 * 60 + i * 30;
        final h = minutes ~/ 60;
        final m = minutes % 60;

        final label =
            "${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}";

        return Container(
          height: slotHeight,
          width: 60,
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.only(top: 2),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black12),
            ),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
        );
      }),
    );
  }

  Widget _timeGrid() {
    return Column(
      children: List.generate((20 - 8) * 2, (_) {
        return Container(
          height: slotHeight,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black12),
            ),
          ),
        );
      }),
    );
  }

  Widget _courseBlock(
  StudentTimetableEntry e, {
  required bool conflict,
}) {
  final color = conflict
      ? Colors.redAccent
      : Colors.blueAccent;

  return Container(
    padding: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
      border: conflict
          ? Border.all(color: Colors.red, width: 2)
          : null,
    ),
    child: Text(
      e.courseCode,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

}
