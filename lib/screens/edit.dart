import 'package:flutter/material.dart';

class EditTaskScreen extends StatefulWidget {
  final Map<String, dynamic> taskData;
  final String taskId;
  final Function(Map<String, dynamic>, String) onSave;

  const EditTaskScreen({
    Key? key,
    required this.taskData, 
    required this.taskId,
    required this.onSave,
  }) : super(key: key);

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String description;
  late String dueDate;
  late bool isPriority;

  @override
  void initState() {
    super.initState();
    title = widget.taskData['title'];
    description = widget.taskData['description'];
    dueDate = widget.taskData['dueDate'];
    isPriority = widget.taskData['priority'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: title,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  title = value!;
                },
              ),
              TextFormField(
                initialValue: description,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  description = value!;
                },
              ),
              TextFormField(
                initialValue: dueDate,
                decoration:
                    const InputDecoration(labelText: 'Due Date (yyyy/mm/dd)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a due date';
                  }
                  if (!RegExp(r'^\d{4}/\d{2}/\d{2}$').hasMatch(value)) {
                    return 'Please enter a valid date (yyyy/mm/dd)';
                  }
                  return null;
                },
                onSaved: (value) {
                  dueDate = value!;
                },
              ),
              CheckboxListTile(
                title: const Text('Set as Priority'),
                value: isPriority,
                onChanged: (value) {
                  setState(() {
                    isPriority = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    widget.onSave(
                      {
                        'title': title,
                        'description': description,
                        'dueDate': dueDate,
                        'priority': isPriority,
                      },
                      widget.taskId
                  );
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
