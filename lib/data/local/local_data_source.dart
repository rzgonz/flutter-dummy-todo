import 'package:sample_amarta/data/local/entity/todo_entity.dart';
import 'package:sample_amarta/data/local/object_box.dart';
import 'package:sample_amarta/main.dart';

late ObjectBox objectbox;

class LocalDataSource {
  late final ObjectBox objectBox;

  LocalDataSource({required this.objectBox});

  static Future<LocalDataSource> init() async {
    var objectBox = await ObjectBox.create();
    return LocalDataSource(objectBox: objectBox);
  }

  int saveTodo(TodoEntity todoEntity) => objectBox.todoBox.put(todoEntity);

  Stream<List<TodoEntity>> getListTodo() => objectBox.todoBox
      .query()
      .watch(triggerImmediately: true)
      .map((event) => event.find());

  bool deleteTodo(TodoEntity todoEntity) =>
      objectBox.todoBox.remove(todoEntity.id);
}
