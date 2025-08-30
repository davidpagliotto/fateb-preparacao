import 'package:flutter/material.dart';

void main() {
  runApp(const TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TaskListPage());
  }
}

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final List<TaskModel> tasks = [
    TaskModel(title: 'Preparar a aula 5'),
    TaskModel(title: 'Ir para academia'),
    TaskModel(title: 'Limpar a casa'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Lista de tarefas'))),
      floatingActionButton: FloatingActionButton(
        onPressed: createTaskDialog(),
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          tasksDashboard(),
          Expanded(child: tasksListView()),
        ],
      ),
    );
  }

  Widget tasksDashboard() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.0, 0.0, 8.0, 0.0),
          child: Text(
            '(${tasks.where((task) => task.isDone).length} / ${tasks.length})',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(8.0, 0.0, 16.0, 0.0),
            child: LinearProgressIndicator(
              value: tasks.where((task) => task.isDone).length / tasks.length,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ),
        ),
      ],
    );
  }

  Widget tasksListView() {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: changeTaskDoneStateButton(index),
          title: Text(tasks[index].title),
          trailing: removeTaskButton(index),
        );
      },
    );
  }

  Widget changeTaskDoneStateButton(int index) {
    return IconButton(
      onPressed: () {
        setState(() {
          tasks[index].changeDoneState();
        });
      },
      icon: Icon(
        tasks[index].isDone ? Icons.check_circle : Icons.circle_outlined,
        color: tasks[index].isDone ? Colors.green : Colors.grey,
      ),
    );
  }

  Widget removeTaskButton(int index) {
    return IconButton(
      onPressed: () {
        setState(() {
          tasks.removeAt(index);
        });
      },
      icon: Icon(Icons.delete),
    );
  }

  VoidCallback createTaskDialog() {
    TextField taskDescriptionInput = TextField(
      controller: TextEditingController(),
      decoration: InputDecoration(hintText: 'Digite a tarefa'),
    );

    return () {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Adicionar tarefa'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [taskDescriptionInput],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    String taskDescription =
                        taskDescriptionInput.controller!.text;
                    if (taskDescription.isEmpty) return;

                    tasks.add(TaskModel(title: taskDescription));
                    Navigator.of(context).pop();
                  });
                },
                child: Text('Adicionar'),
              ),
            ],
          );
        },
      );
    };
  }
}

class TaskModel {
  final String title;
  bool isDone;

  TaskModel({required this.title, this.isDone = false});

  void changeDoneState() {
    isDone = !isDone;
  }
}
