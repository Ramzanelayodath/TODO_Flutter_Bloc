

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/constants/settings.dart';
import 'package:todo_app/cubit/todos_cubit.dart';
import 'package:todo_app/data/models/todo.dart';

class TodosScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodosCubit>(context).fetchTodos();
     return Scaffold(
       appBar: AppBar(
         title: Text('TODO'),
         actions: [
           InkWell(
             child: Padding(
               padding:EdgeInsets.all(10),
               child: Icon(Icons.add),),
             onTap: (){
               Navigator.pushNamed(context, ADD_TODO_ROUTE);
             },
           )
         ],
       ),
       body: BlocBuilder<TodosCubit,TodosState>(
          builder: (context,state){
            if(!(state is TodosLoaded))
              return Center(
                child: CircularProgressIndicator(),
              );
            else{
              final todos = (state).todos;
              
              return  SingleChildScrollView(
                child: Column(
                  children: todos.map((e) => _todo(e,context)).toList(),
                ),
              );
              }

          },
       )
     );
  }

  Widget _todo(Todo todo,context){
    return InkWell(
      child:  Dismissible(key: Key("${todo.id}"),
        child:_todoTile(todo, context),
        background: Container(
          color: Colors.indigo,),
        confirmDismiss: (_)async{
          BlocProvider.of<TodosCubit>(context).changeCompletion(todo);
          return false;
        },),
      onTap: (){
        Navigator.pushNamed(context, EDIT_TODO_ROUTE,arguments: todo);
      },
    );
  }
  
  Widget _todoTile(Todo todo,context){
    return  Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(color: Colors.grey)
          )
      ),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(todo.todoMessage),
          _todoCompletionIndicator(todo)
        ],
      ) ,
    );
  }

  Widget _todoCompletionIndicator(Todo todo){
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(width: 4,
            color: todo.isCompleted? Colors.green : Colors.red),
      ),
    );
  }

}