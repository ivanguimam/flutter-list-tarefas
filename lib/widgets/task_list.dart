import 'package:flutter/material.dart';
import 'package:lista_tarefa/models/Task.dart';
import 'package:lista_tarefa/widgets/task_card.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final Function(Task, bool) onCheck;
  final Function(Task) onDelete;

  const TaskList({
    super.key,
    required this.tasks,
    required this.onCheck,
    required this.onDelete
  });

  @override
  Widget build(BuildContext context) {
    ListView todoList = ListView.separated(
      shrinkWrap: true,
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        Task task = tasks[index];
        return TaskCard(task: task, onCheck: onCheck, onDelete: onDelete);
      },
      separatorBuilder: (context, index) => SizedBox(height: 15),
    );

    Container container = Container(
      padding: EdgeInsets.only(top: 15),
      child: todoList,
    );

    return Flexible(child: container);
  }
}
