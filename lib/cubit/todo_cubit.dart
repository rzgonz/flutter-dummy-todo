import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_amarta/cubit/todo_view_state.dart';
import 'package:sample_amarta/domain/dto/todo_dto.dart';

class TodoCubit extends Cubit<TodoViewState> {
  TodoCubit() : super(const TodoViewState());

  void insertOrUpdateTodo(TodoDto todoDto) {
    var newList = List.of(state.listTodo);
    print("TODO ${todoDto.name} => ${todoDto.isDone}");
    if (newList.where((element) => element.name == todoDto.name).isNotEmpty) {
      var updateindex =
          newList.indexWhere((element) => element.name == todoDto.name);
      print("TODO ${updateindex} = ${todoDto.name} => ${todoDto.isDone}");
      newList[updateindex] = todoDto;
    } else {
      newList.add(todoDto);
    }
    emit(state.copyWith(listTodo: newList));
  }
}
