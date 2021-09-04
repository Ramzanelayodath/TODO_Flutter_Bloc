import 'package:flutter/material.dart';
import 'package:todo_app/presentation/router.dart';
import 'package:todo_app/presentation/screens/todos_screen.dart';

void main() {
  runApp(MyApp(AppRouter()));
}

class MyApp extends StatelessWidget {
   AppRouter router;

   MyApp(this.router);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: router.generateRoute,
    );
  }
}

