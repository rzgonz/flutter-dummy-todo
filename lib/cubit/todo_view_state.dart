import 'package:equatable/equatable.dart';
import 'package:sample_amarta/domain/dto/todo_dto.dart';

class TodoViewState extends Equatable {
  final List<TodoDto> listTodo;
  const TodoViewState({
    this.listTodo = const <TodoDto>[],
  });

  TodoViewState copyWith({
    List<TodoDto>? listTodo,
  }) {
    return TodoViewState(
      listTodo: List.of(listTodo ?? []),
    );
  }

  @override
  List<Object> get props => [listTodo];
}
