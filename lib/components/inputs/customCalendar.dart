import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({super.key});

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
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
    List<String> monthNames = [
      "Janvier",
      "Février",
      "Mars",
      "Avril",
      "Mai",
      "Juin",
      "Juillet",
      "Août",
      "Septembre",
      "Octobre",
      "Novembre",
      "Décembre"
    ];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 8.0),
            Text(
              '${monthNames[_focusedDay.month - 1]}  ${_focusedDay.year}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            const SizedBox(width: 16),
            IconButton(
              onPressed: () {
                setState(() {
                  if (_focusedDay.month == 1) {
                    _focusedDay = DateTime(_focusedDay.year - 1, 12);
                  } else {
                    _focusedDay =
                        DateTime(_focusedDay.year, _focusedDay.month - 1);
                  }
                });
                debugPrint('mois--');
              },
              icon: const Icon(Icons.arrow_back),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (_focusedDay.month == 12) {
                    _focusedDay = DateTime(_focusedDay.year + 1, 1);
                  } else {
                    _focusedDay =
                        DateTime(_focusedDay.year, _focusedDay.month + 1);
                  }
                });
                debugPrint('mois++');
              },
              icon: const Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ],
    );
  }
}
