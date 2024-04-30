import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:lista_tarefa/models/Task.dart';

class TaskRepository {
  Future<File> _getFile() async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    return File("${appDocumentsDir.path}/data.json");
  }

  void save(List<Task> tasks) async {
    File file = await _getFile();
    String encoded = json.encode(tasks);

    await file.writeAsString(encoded);
  }

  Future<List<Task>> getAll() async {
    try {
      File file = await _getFile();
      String encodedData = await file.readAsString();
      List decodedTodos = json.decode(encodedData) as List;

      return decodedTodos.map((task) => Task.fromJson(task)).toList();
    } catch (e) {
      return [];
    }
  }
}
