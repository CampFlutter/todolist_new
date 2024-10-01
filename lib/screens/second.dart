import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_todolist/screens/provider.dart';

class Second extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Stylish To-Do List',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: TodoListScreen(),
      ),
    );
  }
}

class TodoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/44.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildInputSection(context),
              Expanded(child: _buildTodoList(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputSection(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Enter a new task',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.add_circle, color: Colors.orange),
            onPressed: () {
              Provider.of<TodoProvider>(context, listen: false)
                  .addTodo(_controller.text);
              _controller.clear();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTodoList(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, todoProvider, child) {
        return ListView.builder(
          itemCount: todoProvider.todos.length,
          itemBuilder: (context, index) {
            final todo = todoProvider.todos[index];
            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                leading: IconButton(
                  icon: Icon(
                    todo.isDone
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: todo.isDone ? Colors.green : Colors.grey,
                  ),
                  onPressed: () => todoProvider.toggleTodoStatus(index),
                ),
                title: Text(
                  todo.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    decoration: todo.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => todoProvider.removeTodo(index),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
