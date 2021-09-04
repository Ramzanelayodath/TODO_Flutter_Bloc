import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/cubit/edit_todo_cubit.dart';
import 'package:todo_app/data/models/todo.dart';

class EditTodoScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final Todo todo;

  EditTodoScreen(this.todo);

  @override
  Widget build(BuildContext context) {
    _controller.text = todo.todoMessage;
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit TODO'),
          actions: [
            InkWell(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.delete),
              ),
              onTap: () {
                BlocProvider.of<EditTodoCubit>(context).deleteTodo(todo);
              },
            )
          ],
        ),
        body: BlocListener<EditTodoCubit, EditTodoState>(
          listener: (context, state) {
            if(state is TodoEdited){
              Navigator.pop(context);
            }else if(state is EditTodoError){
              Fluttertoast.showToast(
                  msg: state.error,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
          },
          child: _body(context),
        )
    );
  }

  Widget _body(context) {
    return Padding(padding: EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            autofocus: true,
            controller: _controller,
            decoration: InputDecoration(
                hintText: "Enter todo message..."
            ),
          ),
          SizedBox(height: 10,),
          InkWell(
            child: _editButton(context),
            onTap: () {
              final message = _controller.text;
              BlocProvider.of<EditTodoCubit>(context).editTodo(todo,message);
            },
          )
        ],
      ),);
  }

  Widget _editButton(context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text('Edit Todo', style: TextStyle(color: Colors.white),)
      ),
    );
  }
}