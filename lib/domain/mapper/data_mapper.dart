import 'package:sample_amarta/data/local/entity/todo_entity.dart';
import 'package:sample_amarta/domain/dto/todo_dto.dart';

class DataMapper {
  static TodoEntity todoDtoToEntity(TodoDto todoDto) =>
      TodoEntity(id: todoDto.id, name: todoDto.name, isDone: todoDto.isDone);

  static List<TodoDto> listTodoEntityToDto(List<TodoEntity> entity) =>
      entity.map((e) => DataMapper.todoEntityToDto(e)).toList();

  static TodoDto todoEntityToDto(TodoEntity entity) =>
      TodoDto(id: entity.id, name: entity.name, isDone: entity.isDone);
}
