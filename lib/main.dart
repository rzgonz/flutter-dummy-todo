import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sample_amarta/cubit/todo_cubit.dart';
import 'package:sample_amarta/cubit/todo_view_state.dart';
import 'package:sample_amarta/domain/dto/todo_dto.dart';

void main() {
  // add this, and it should be the first line in main method
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider(
          create: (context) => TodoCubit(),
          child: const MyHomePage(title: 'Todo List'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<TodoDto> _listTodo = [];
  final TextEditingController _textFieldController = TextEditingController();

  void _addMoreTodo(String todoName) {
    var newTodo = TodoDto(id: 0, name: todoName, isDone: false);
    context.read<TodoCubit>().insertOrUpdateTodo(newTodo);
    _listTodo.add(newTodo);
  }

  void _updateTodo(int index) {
    var oldTodo = _listTodo[index];
    oldTodo.isDone = true;
    context.read<TodoCubit>().insertOrUpdateTodo(oldTodo);
    _listTodo[index] = oldTodo;
    setState(() {});
  }

  void _displayTextInputDialog() async {
    var todoValue = '';
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add a new todo Items'),
            content: TextField(
              onChanged: (value) {
                todoValue = value;
              },
              controller: _textFieldController,
              decoration:
                  const InputDecoration(hintText: "Type your new todo "),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              TextButton(
                child: const Text(
                  'Add',
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  if (todoValue.isEmpty) {
                    _showToastMessage("Todo name is empty");
                  } else if (_listTodo
                      .where((element) => element.name == todoValue)
                      .isNotEmpty) {
                    _showToastMessage("Todo $todoValue is Avilable");
                  } else {
                    Navigator.pop(context);
                    _addMoreTodo(todoValue);
                    _textFieldController.text = "";
                  }
                },
              ),
            ],
          );
        });
  }

  void _showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Center(child: Text(widget.title)),
      ),
      body: BlocBuilder<TodoCubit, TodoViewState>(
        builder: (context, state) {
          return ListView.builder(
              itemCount: state.listTodo.length,
              itemBuilder: ((context, index) => GestureDetector(
                  onTap: () => {_updateTodo(index)},
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 8, bottom: 8),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Center(
                            child: Text(
                              state.listTodo[index].name[0].toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          state.listTodo[index].name,
                          style: !state.listTodo[index].isDone
                              ? const TextStyle(
                                  color: Colors.black, fontSize: 18)
                              : const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                  decoration: TextDecoration.lineThrough),
                        ),
                      ],
                    ),
                  ))));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _displayTextInputDialog,
        tooltip: 'add More Todo',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
