import 'package:flutter/material.dart';

class ReminderSetupScreen extends StatefulWidget {
  final String taskTitle;

  const ReminderSetupScreen({Key? key, required this.taskTitle}) : super(key: key);

  @override
  _ReminderSetupScreenState createState() => _ReminderSetupScreenState();
}

class _ReminderSetupScreenState extends State<ReminderSetupScreen> {
  late DateTime selectedDate;
  late TimeOfDay selectedTime;
  bool repeatReminder = false; 

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    selectedTime = TimeOfDay.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  void _saveReminder() {
    // Implement logic to save reminder with selectedDate, selectedTime, and repeatReminder
    // You can use local notifications plugin like flutter_local_notifications for local notifications
    // Example: scheduleNotification(selectedDate, selectedTime, widget.taskTitle, repeatReminder);
    
    // After saving, close the screen
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Reminder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: const Text('Select Date'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: const Text('Select Time'),
            ),
            const SizedBox(height: 10),
            CheckboxListTile(
              title: const Text('Repeat Reminder'),
              value: repeatReminder,
              onChanged: (value) {
                setState(() {
                  repeatReminder = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _saveReminder,
                  child: const Text('Save Reminder'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
