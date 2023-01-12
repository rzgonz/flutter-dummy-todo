import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sample_amarta/domain/dto/todo_dto.dart';

class TodoViewState extends Equatable {
  final List<TodoDto> listTodo;
  final bool needRefresh;
  const TodoViewState(
      {this.listTodo = const <TodoDto>[], this.needRefresh = false});

  TodoViewState copyWith({List<TodoDto>? listTodo, bool? needRefresh}) {
    return TodoViewState(
        listTodo: List.of(listTodo ?? []), needRefresh: needRefresh ?? false);
  }

  @override
  List<Object> get props => [listTodo, needRefresh];
}
