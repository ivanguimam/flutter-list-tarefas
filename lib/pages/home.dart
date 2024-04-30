import 'package:flutter/material.dart';
import 'package:lista_tarefa/models/Task.dart';
import 'package:lista_tarefa/repositories/task_repository.dart';
import 'package:lista_tarefa/widgets/input_action.dart';
import 'package:lista_tarefa/widgets/task_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TaskRepository taskRepository = TaskRepository();

  List<Task> tasks = [];

  onAdd(String value) {
    setState(() {
      tasks.add(Task(name: value, selected: false));
      taskRepository.save(tasks);
    });
  }

  onCheck(Task task, bool newValue) {
    setState(() {
      int index = tasks.indexOf(task);
      task.selected = newValue;
      tasks[index] = task;

      taskRepository.save(tasks);
    });
  }

  onDelete(Task task) {
    Task deletedTask = task;
    int deletedIndex = tasks.indexOf(task);

    setState(() {
      tasks.remove(task);
      taskRepository.save(tasks);
    });

    ScaffoldMessenger.of(context).clearSnackBars();

    showSnackbar(deletedTask, deletedIndex);
  }

  undo(Task task, int index) {
    setState(() {
      tasks.insert(index, task);
      taskRepository.save(tasks);
    });
  }

  showSnackbar(Task task, int index) {
    TextStyle messageStyle = TextStyle(color: Colors.white);
    Text message = Text('Tarefa "${task.name}" foi removida', style: messageStyle);

    SnackBarAction action = SnackBarAction(
      label: 'Desfazer',
      onPressed: () {
        undo(task, index);
      },
      textColor: Colors.white
    );

    SnackBar snackBar = SnackBar(
      action: action,
      backgroundColor: Colors.blue,
      content: message,
      duration: Duration(seconds: 5),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> onRefresh() async {
    sorTasks();
  }

  sorTasks() {
    setState(() {
      tasks.sort((taskA, taskB) {
        if (taskA.selected && !taskB.selected) return 1;
        if (!taskA.selected && taskB.selected) return -1;
        return 0;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      taskRepository.getAll().then((List<Task> tasks) {
        this.tasks = tasks;
        sorTasks();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    InputAction input = InputAction(onAdd: onAdd);

    Column column = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [input, TaskList(tasks: tasks, onCheck: onCheck, onDelete: onDelete)],
    );

    Container container = Container(
      padding: EdgeInsets.all(16),
      child: column,
    );

    RefreshIndicator refreshIndicator = RefreshIndicator(
      onRefresh: onRefresh,
      child: container,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text('Lista de Tarefas'),
      ),
      body: refreshIndicator,
    );
  }
}
