import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ApiCalendar extends StatefulWidget {
  const ApiCalendar({Key? key}) : super(key: key);

  @override
  State<ApiCalendar> createState() => _ApiCalendarState();
}

class _ApiCalendarState extends State<ApiCalendar> {
  late Map<DateTime, List<String>> events;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();

    // Example: these dates would normally come from your API
    events = {
      DateTime(2025, 8, 11): ["Meeting"],
      DateTime(2025, 8, 12): ["Holiday"],
      DateTime(2025, 8, 23): ["Special event"],
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TableCalendar(
        firstDay: DateTime.utc(2000, 1, 1),
        lastDay: DateTime.utc(2100, 12, 31),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        eventLoader: (day) {
          return events[DateTime(day.year, day.month, day.day)] ?? [];
        },
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          markerDecoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
        ),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
      ),
    );
  }
}
