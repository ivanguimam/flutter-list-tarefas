import 'package:flutter/material.dart';

class InputAction extends StatefulWidget {
  const InputAction({
    super.key,
    required this.onAdd
  });

  final Function(String) onAdd;

  @override
  State<InputAction> createState() => _InputActionState(onAdd: onAdd);
}

class _InputActionState extends State<InputAction> {
  late String value;

  final TextEditingController inputController = TextEditingController();

  _InputActionState({
    required this.onAdd
  });

  final Function(String) onAdd;

  onChangeValue(String value) {
    setState(() {
      this.value = value;
    });
  }

  onAddTask() {
    this.onAdd(value);
    inputController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle labelStyle = TextStyle(color: Colors.blue);

    InputDecoration decoration = InputDecoration(
      border: UnderlineInputBorder(),
      labelStyle: labelStyle,
      labelText: 'Nova Tarefa',
    );

    TextField input = TextField(
      controller: inputController,
      decoration: decoration,
      onChanged: onChangeValue,
      onSubmitted: (String value) {
        onAddTask();
      },
    );

    Expanded fieldExpanded = Expanded(
      child: input
    );

    ButtonStyle btnStyle = ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      padding: EdgeInsets.only(left: 30, top: 8, bottom: 8, right: 30),
    );

    TextStyle addBtnStyle = TextStyle(
      color: Colors.white
    );
    Text addBtnText = Text('ADD', style: addBtnStyle);

    ElevatedButton addBtn = ElevatedButton(
      onPressed: onAddTask,
      style: btnStyle,
      child: addBtnText
    );

    SizedBox space = SizedBox(width: 8);

    return Row(
      children: [fieldExpanded, space, addBtn],
    );
  }
}
