import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_amarta/cubit/todo_view_state.dart';
import 'package:sample_amarta/domain/dto/todo_dto.dart';
import 'package:sample_amarta/domain/interactor/interactor.dart';

import '../main.dart';

class TodoCubit extends Cubit<TodoViewState> {
  final Interactor interactor;

  TodoCubit({required this.interactor}) : super(const TodoViewState()) {
    getListTodo();
  }

  void insertOrUpdateTodo(TodoDto todoDto) {
    var newList = List.of(state.listTodo);
    if (newList.where((element) => element.name == todoDto.name).isNotEmpty) {
      var updateindex =
          newList.indexWhere((element) => element.name == todoDto.name);
      newList[updateindex] = todoDto;
      interactor.saveTodo(todoDto);
    } else {
      interactor.saveTodo(todoDto);
      newList.add(todoDto);
    }
    getListTodo();
  }

  void getListTodo() async {
    var listTodo = await interactor.getListTodo().first;
    emit(state.copyWith(listTodo: listTodo));
  }

  void deleteTodo(TodoDto todoDto) {
    interactor.deleteTodo(todoDto);
    getListTodo();
  }
}
