import 'package:flutter/material.dart';

class StudentAttendance extends StatefulWidget {
  @override
  _StudentAttendanceState createState() => _StudentAttendanceState();
}

class _StudentAttendanceState extends State<StudentAttendance> {
  bool isPresent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Présence des étudiants'),
      ),
      body: Center(
        child: CheckboxListTile(
          title: Text('Présent'),
          value: isPresent,
          onChanged: (newValue) {
            setState(() {
              isPresent = newValue;
            });
          },
        ),
      ),
    );
  }
}
