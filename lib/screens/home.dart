import 'package:flutter/material.dart';
import 'auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Mock data for tasks
  final List<Map<String, dynamic>> _tasks = [
    {
      'title': 'Task 1',
      'description': 'Description for Task 1',
      'dueDate': '2024-07-15',
      'priority': true,
    },
    {
      'title': 'Task 2',
      'description': 'Description for Task 2',
      'dueDate': '2024-07-16',
      'priority': false,
    },
    {
      'title': 'Task 3',
      'description': 'Description for Task 3',
      'dueDate': '2024-07-17',
      'priority': false,
    },
  ];

  void _logout() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const AuthScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Your Tasks',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _tasks.length,
                  itemBuilder: (context, index) {
                    var task = _tasks[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        leading: task['priority']
                            ? const Icon(Icons.star, color: Colors.amber)
                            : null,
                        title: Text(task['title']),
                        subtitle: Text(task['description']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                // Handle edit task
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                // Handle delete task
                                setState(() {
                                  _tasks.removeAt(index);
                                });
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          // Handle view task details
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Handle add new task
          _showAddTaskDialog(context);
        },
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String title = '';
    String description = '';
    String dueDate = '';
    bool isPriority = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Add New Task'),
              content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
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
                      decoration:
                          const InputDecoration(labelText: 'Description'),
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
                      decoration: const InputDecoration(labelText: 'Due Date'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a due date';
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
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      setState(() {
                        isPriority =
                            isPriority; // Refresh local state if needed
                      });
                      Navigator.of(context).pop({
                        'title': title,
                        'description': description,
                        'dueDate': dueDate,
                        'priority': isPriority,
                      });
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    ).then((newTask) {
      if (newTask != null) {
        setState(() {
          _tasks.add(newTask);
        });
      }
    });
  }
}
