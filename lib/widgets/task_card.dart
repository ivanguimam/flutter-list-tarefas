import 'package:flutter/material.dart';
import 'package:lista_tarefa/models/Task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final Function(Task, bool) onCheck;
  final Function(Task) onDelete;

  const TaskCard({
    super.key,
    required this.task,
    required this.onCheck,
    required this.onDelete
  });

  void onChangeCheck(bool? value) {
    onCheck(task, !task.selected);
  }

  void onDeleteTask() {
    onDelete(task);
  }

  @override
  Widget build(BuildContext context) {
    Icon icon = Icon(
      task.selected ? Icons.check : Icons.warning_amber,
      color: Colors.white,
      size: 22,
    );

    BoxDecoration containerDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      color: Colors.blue,
    );

    Container iconContainer = Container(
      decoration: containerDecoration,
      padding: EdgeInsets.all(13),
      child: icon,
    );

    Text name = Text(task.name);

    Container nameContainer = Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: name,
    );

    Row nameRow = Row(
      children: [nameContainer],
    );

    Expanded nameExpanded = Expanded(
      child: nameRow,
    );

    Checkbox checkbox = Checkbox(
      checkColor: Colors.white,
      value: task.selected,
      onChanged: onChangeCheck,
    );

    Row row = Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [iconContainer, nameExpanded, checkbox],
    );

    Align dimissibleContainerAlign = const Align(
      alignment: Alignment(-0.9, 0),
      child: Icon(Icons.delete, color: Colors.white),
    );
    Container dimissibleContainer = Container(
      color: Colors.red,
      child: dimissibleContainerAlign,
    );

    Dismissible dismissible = Dismissible(
      background: dimissibleContainer,
      direction: DismissDirection.startToEnd,
      onDismissed: (DismissDirection direction) {
        onDeleteTask();
      },
      key: Key(DateTime.now().millisecond.toString()),
      child: row,
    );

    return IntrinsicHeight(
      child: dismissible,
    );
  }
}
