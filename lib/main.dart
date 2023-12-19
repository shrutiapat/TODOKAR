import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'calendar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODOKAR',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<String> tasks = [];
  List<bool> taskStatus = [];

  late TextEditingController _taskController;

  @override
  void initState() {
    super.initState();
    _taskController = TextEditingController();
  }


  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  void _addTask(String newTask) {
    setState(() {
      tasks.add(newTask);
      taskStatus.add(false);
    });
    Navigator.pop(context); // Go back to the previous screen after adding task
    _taskController.clear();
  }
  List<Widget> _buildTasks(bool isCompleted) {
    List<Widget> taskWidgets = [];

    for (int i = 0; i < tasks.length; i++) {
      if (taskStatus[i] == isCompleted) {
        taskWidgets.add(
          Dismissible(
            key: Key(tasks[i]),
            onDismissed: (direction) {
              setState(() {
                tasks.removeAt(i);
                taskStatus.removeAt(i);
              });
            },
            child: ListTile(
              leading: Checkbox(
                value: taskStatus[i],
                onChanged: (bool? value) {
                  setState(() {
                    taskStatus[i] = value!;
                  });
                },
              ),
              title: Text(
                tasks[i],
                style: TextStyle(
                  decoration: taskStatus[i]
                      ? TextDecoration.lineThrough
                      : null,

                ),
              ),
            ),
          ),
        );
      }
    }
    return taskWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0), // Set the preferred height of the app bar
        child: Container(
          decoration: BoxDecoration(
            color: Colors.pink.shade200, // Background color for the highlighted area
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Shadow color
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // Shadow position
              ),
            ],
          ),
          child: AppBar(
            title: Text(
              'TODOKAR',
              style: TextStyle(
                color: Colors.white, // Title text color
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.transparent, // Make app bar transparent
            elevation: 0, // Remove the shadow below the app bar
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text('Today', style: GoogleFonts.nunitoSans(fontSize: 20, fontWeight: FontWeight.w700)),
                ),
                ..._buildTasks(false),
                ListTile(
                  title: Text('Completed',style: GoogleFonts.nunitoSans(fontSize: 20, fontWeight: FontWeight.w700)),
                ),
                ..._buildTasks(true),

              ],
            ),
          ),
        ],
      ),

      floatingActionButton:FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskScreen(_addTask),
            ),
          );
        },


        child: Icon(Icons.add),
        backgroundColor: Colors.pink.shade200, // Change color of button
      ),
      bottomNavigationBar: Container(
        color: Colors.grey[200],
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [GestureDetector(
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



class AddTaskScreen extends StatelessWidget {
  final Function(String) addTaskCallback;
  final TextEditingController _taskController = TextEditingController();

  AddTaskScreen(this.addTaskCallback);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _taskController,
              decoration: InputDecoration(
                hintText: 'Enter a task',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                addTaskCallback(_taskController.text);
              },
              child: Text('Add Task', style: TextStyle(color: Colors.pink.shade200)),
            ),
          ],
        ),
      ),
    );
  }
}
