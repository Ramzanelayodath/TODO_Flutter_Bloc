
import 'dart:convert';

import 'package:http/http.dart';

class NetworkService{
  final baseurl = "http://10.0.2.2:3000";

  Future<List<dynamic>> fetchTodos() async {
     try{
       final response =  await get(Uri.parse(baseurl+"/todos"));
       print(response.body);
       return jsonDecode(response.body) as List;
     }catch(e){
       return [];
     }
  }

  Future<bool> patchTodo(Map<String, String> patchObj, int id)async {
     try{
        await patch(Uri.parse(baseurl+"/todos/$id"),body: patchObj);
        return true;
     }catch(e){
       return false;
     }
  }

  addTodo(Map<String, String> todoObj)async {
    try{
       final resp =  await post(Uri.parse(baseurl+"/todos"),body: todoObj);
       return jsonDecode(resp.body);
    }catch(e){
      return null;
    }
  }

  Future<bool> deleteTodo(int id)async {
    try{
       await delete(Uri.parse(baseurl+"/todos/${id}"));
       return true;
    }catch(E){
      return false;
    }
  }

}