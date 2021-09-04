import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/cubit/todos_cubit.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/repository.dart';

part 'edit_todo_state.dart';

class EditTodoCubit extends Cubit<EditTodoState> {

  final Repository repository;
  final TodosCubit todosCubit;

  EditTodoCubit(this.repository, this.todosCubit): super(EditTodoInitial());

  void deleteTodo(Todo todo) {

    repository.deleteTodo(todo.id).then((isDeleted){
       if(isDeleted){
         todosCubit.deleteTodo(todo);
         emit(TodoEdited());
       }
    } );
  }

  void editTodo(Todo todo,String message) {
    if(message.isEmpty){
      emit(EditTodoError("Enter Todo"));
      return;
    }else{
      repository.updateTodo(message,todo.id).then((isUpdated){
        if(isUpdated){
          todo.todoMessage = message;
          todosCubit.updateTodoList();
          emit(TodoEdited());
        }
      });
    }

  }


}
