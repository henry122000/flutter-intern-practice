import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'edit.dart';
import 'profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  void _logout() async {
    await _firebaseAuth.signOut();
  }

  void _editTask(DocumentSnapshot task) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditTaskScreen(
          taskData: task.data() as Map<String, dynamic>,
          taskId: task.id,
          onSave: (updatedTask, taskId) {
            _firestore.collection('tasks').doc(task.id).update(updatedTask);
          },
        ),
      ),
    );
  }

  void _addTask(Map<String, dynamic> taskData) {
    _firestore.collection('tasks').add(taskData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () async {
              ProfileDialog.showProfileDialog(context, _firebaseAuth);
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _firestore.collection('tasks').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final tasks = snapshot.data!.docs;
          return Center(
            child: Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Current Tasks',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  tasks.isEmpty
                      ? const Text(
                          'There is currently no task',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: tasks.length,
                            itemBuilder: (context, index) {
                              var task = tasks[index];
                              return SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: Card(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: ListTile(
                                      leading: task['priority']
                                          ? const Icon(Icons.star,
                                              color: Colors.amber)
                                          : null,
                                      title: Text(task['title']),
                                      subtitle: Text(task['description']),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.edit),
                                            onPressed: () {
                                              _editTask(task);
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete),
                                            onPressed: () {
                                              _firestore
                                                  .collection('tasks')
                                                  .doc(task.id)
                                                  .delete();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ));
                            },
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
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
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Form(
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
                        decoration: const InputDecoration(
                            labelText: 'Due Date (yyyy/mm/dd)'),
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
                      Row(
                        children: [
                          Checkbox(
                            value: isPriority,
                            onChanged: (value) {
                              setState(() {
                                isPriority = value!;
                              });
                            },
                          ),
                          const Text('Set as Priority'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _addTask({
                        'title': title,
                        'description': description,
                        'dueDate': dueDate,
                        'priority': isPriority,
                      });
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Add Task'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
