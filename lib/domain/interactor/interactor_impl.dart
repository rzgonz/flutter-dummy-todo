import 'package:sample_amarta/domain/mapper/data_mapper.dart';
import 'package:sample_amarta/domain/repository.dart';
import 'package:sample_amarta/domain/dto/todo_dto.dart';
import 'package:sample_amarta/main.dart';
import 'interactor.dart';

class InteractorImpl implements Interactor {
  late final Repository repository;

  InteractorImpl({required this.repository});

  @override
  bool deleteTodo(TodoDto todoDto) =>
      repository.deleteTodo(DataMapper.todoDtoToEntity(todoDto));

  @override
  Stream<List<TodoDto>> getListTodo() {
    var data = repository.getListTodo();
    var dataMapper = data.map((event) => DataMapper.listTodoEntityToDto(event));
    return dataMapper;
  }

  @override
  int saveTodo(TodoDto todoDto) =>
      repository.saveTodo(DataMapper.todoDtoToEntity(todoDto));
}
