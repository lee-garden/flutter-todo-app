import 'package:first_flutter_app/model/todo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(primarySwatch: Colors.green),
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {

  final _items = <Todo>[];

  final _todoController = TextEditingController();

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  Widget _buildItemWidget(Todo todo) {
    return ListTile(
      onTap: () => _toggleTodo(todo),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => _deleteTodo(todo),
      ),
      title: Text(
        todo.title,
        style: todo.isDone?
            const TextStyle(
              decoration: TextDecoration.lineThrough,
              fontStyle: FontStyle.italic,
            ) : null,
      ),
    );
  }

  void _addTodo(Todo todo) {
    setState(() {
      _items.add(todo);
      _todoController.text = '';
    });
  }

  void _deleteTodo(Todo todo) {
    setState(() {
      _items.remove(todo);
    });
  }

  void _toggleTodo(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('남은 할 일'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(child: TextField(
                  controller: _todoController,
                ),),
                ElevatedButton(
                    onPressed: () => _addTodo(Todo(_todoController.text)),
                    style: ElevatedButton.styleFrom( onPrimary: Colors.green),
                    child: const Text('추가하기', style: TextStyle( color: Colors.white),),
                )
              ],
            ),
            Expanded(
                child: ListView(
                  children: _items.map((todo) => _buildItemWidget(todo)).toList(),
                )
            )
          ],
        )
      )
    );
  }
}