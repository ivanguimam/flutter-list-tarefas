class Task {
  String name;
  bool selected;

  Task({required this.name, required this.selected});

  Task.fromJson(Map<String, dynamic> jsonTodo):
        name = jsonTodo['name'],
        selected = jsonTodo['selected'];

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'selected': selected,
    };
  }
}
