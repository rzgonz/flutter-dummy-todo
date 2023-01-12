import 'package:sample_amarta/domain/dto/todo_dto.dart';

abstract class Interactor {
  Stream<List<TodoDto>> getListTodo();
  int saveTodo(TodoDto todoDto);
  bool deleteTodo(TodoDto todoDto);
}
