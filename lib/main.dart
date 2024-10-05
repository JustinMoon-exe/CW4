import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Task App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: TaskScreen(),
    );
  }
}

class Task {
  String taskName;
  bool isDone;

  Task(this.taskName, this.isDone);
}

class TaskScreen extends StatefulWidget {
  @override
  TaskScreenState createState() => TaskScreenState();
}

class TaskScreenState extends State<TaskScreen> {
  List<Task> myTasks = [];
  TextEditingController textController = TextEditingController();

  void addNewTask() {
    setState(() {
      myTasks.add(Task(textController.text, false));
    });
    textController.clear();
  }

  void markTaskDone(int taskIndex) {
    setState(() {
      myTasks[taskIndex].isDone = !myTasks[taskIndex].isDone;
    });
  }

  void removeTask(int taskIndex) {
    setState(() {
      myTasks.removeAt(taskIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Tasks')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(hintText: 'Type task here'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (textController.text.isNotEmpty) {
                      addNewTask();
                    }
                  },
                  child: Text('Add Task'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: myTasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Checkbox(
                    value: myTasks[index].isDone,
                    onChanged: (value) {
                      markTaskDone(index);
                    },
                  ),
                  title: Text(
                    myTasks[index].taskName,
                    style: TextStyle(
                      decoration: myTasks[index].isDone
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      removeTask(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}