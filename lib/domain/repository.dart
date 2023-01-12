import 'package:sample_amarta/data/local/entity/todo_entity.dart';
import 'package:sample_amarta/data/local/local_data_source.dart';
import 'package:sample_amarta/main.dart';

class Repository {
  late final LocalDataSource localDataSource;

  Repository({required this.localDataSource});

  int saveTodo(TodoEntity todoEntity) => localDataSource.saveTodo(todoEntity);

  Stream<List<TodoEntity>> getListTodo() => localDataSource.getListTodo();

  bool deleteTodo(TodoEntity todoEntity) =>
      localDataSource.deleteTodo(todoEntity);
}
