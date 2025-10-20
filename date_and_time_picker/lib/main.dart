import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(home: Datetime()));
}

class Datetime extends StatefulWidget {
  const Datetime({super.key});

  @override
  State<Datetime> createState() => _DatetimeState();
}

class _DatetimeState extends State<Datetime> {
  
  DateTime? selectedDate;
  TimeOfDay? selectedtime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
                Text(
      selectedDate == null
          ? "You haven't picked a date yet."
          : DateFormat('MM-dd-yyyy').format(selectedDate!),
    ),

            Text(
      selectedtime == null ? "You haven't picked a time yet." : selectedtime!.format(context),
    ),
            SizedBox(height: 30,),
            FilledButton.tonal(
              onPressed: () async {
                var Date = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2004),
                  initialDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                setState(() {
                  selectedDate = Date;
                });
              },
              child: Icon(Icons.date_range),
            ),
            SizedBox(height: 20),
            FilledButton.tonal(
              onPressed: () async {
                var time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                  initialEntryMode: TimePickerEntryMode.input,
                );
                setState(() {
                  selectedtime = time;
                });
              },
              child: Icon(Icons.timeline),
            ),
          ],
        ),
      ),
    );
  }
}
