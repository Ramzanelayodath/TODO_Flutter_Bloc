import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/cubit/add_todo_cubit.dart';

class AddTodoScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADD TODO'),
      ),
      body: BlocListener<AddTodoCubit, AddTodoState>(
        listener: (context, state) {
           if(state is TodoAdded){
             Navigator.pop(context);
           }else if(state is AddTodoError){
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
        child: Container(
          margin: EdgeInsets.all(20),
          child: _body(context),
        ),
      ),
    );
  }

  Widget _body(context) {
    return Column(
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
          child: _addButton(context),
          onTap: () {
            final message = _controller.text;
            BlocProvider.of<AddTodoCubit>(context).addTodo(message);
          },
        )
      ],
    );
  }

  Widget _addButton(context) {
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
        child: BlocBuilder<AddTodoCubit, AddTodoState>(
          builder: (context, state) {
            if (state is AddingTodo)
              return CircularProgressIndicator();
            return Text('Add Todo', style: TextStyle(color: Colors.white),);
          },
        ),
      ),
    );
  }
}

