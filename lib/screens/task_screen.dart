import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<ParseObject> tasks = [];

  Future<void> fetchTasks() async {
    final QueryBuilder<ParseObject> query = QueryBuilder<ParseObject>(ParseObject('Task'))
      ..orderByDescending('createdAt');

    final response = await query.query();

    if (response.success && response.results != null) {
      setState(() {
        tasks = response.results as List<ParseObject>;
      });
    }
  }

  Future<void> addTask(String title, DateTime dueDate) async {
    final task = ParseObject('Task')
      ..set('title', title)
      ..set('dueDate', dueDate)
      ..set('completed', false);

    await task.save();
    fetchTasks();
  }

  Future<void> deleteTask(String taskId) async {
    final task = ParseObject('Task')..objectId = taskId;
    await task.delete();
    fetchTasks();
  }

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tasks')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.get<String>('title') ?? ''),
            subtitle: Text('Due: ${task.get<DateTime>('dueDate')?.toLocal()}'),
            trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                    Checkbox(
                        value: task.get<bool>('completed'),
                        onChanged: (bool? value) async {
                          task.set('completed', value);
                          await task.save();
                          fetchTasks();
                        },
                    ),
                    IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => deleteTask(task.objectId!),
                    ),
                ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) {
            final TextEditingController titleController = TextEditingController();
            final TextEditingController dueDateController = TextEditingController();
            return AlertDialog(
              title: Text('Add Task'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(controller: titleController, decoration: InputDecoration(labelText: 'Title')),
                  TextField(controller: dueDateController, decoration: InputDecoration(labelText: 'Due Date (YYYY-MM-DD)')),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    addTask(titleController.text, DateTime.parse(dueDateController.text));
                    Navigator.pop(context);
                  },
                  child: Text('Add'),
                )
              ],
            );
          },
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
