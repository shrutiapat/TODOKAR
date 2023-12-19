import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'main.dart';

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
        backgroundColor: Colors.pink.shade200,
      ),
      body: CalendarWidget(),
      bottomNavigationBar: Container(
        color: Colors.grey[200],
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Placeholder for Task button
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TodoListScreen()),
                    );
                  },
                  child: Icon(Icons.today, size: 40),
                ),
                SizedBox(height: 4),
                Text('Task', style: TextStyle(fontWeight: FontWeight.bold)),

              ],
            ),
            // Placeholder for Calendar button
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CalendarScreen()),
                    );
                  },
                  child: Icon(Icons.calendar_today, size: 40),
                ),
                SizedBox(height: 4),
                Text('Calendar', style: TextStyle(fontWeight: FontWeight.bold)),

              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarFormat: _calendarFormat,
      focusedDay: _focusedDay,
      firstDay: DateTime(2000),
      lastDay: DateTime(2050),
      headerStyle: HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
      ),
      onFormatChanged: (format) {
        setState(() {
          _calendarFormat = format;
        });
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },
    );
  }
}
