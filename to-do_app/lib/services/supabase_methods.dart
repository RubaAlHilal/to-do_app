import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:to_do_with_database/model/to_do_model.dart';

class SupabaseMethods {
  final supabase = Supabase.instance.client;

  Future<List<ToDoModel>> getToDo() async {
    final data = await supabase.from("to_do").select("*");
    print(data);
    List<ToDoModel> todoList = [];

    for (var element in data) {
      todoList.add(ToDoModel.fromJson(element));
    }
    return todoList;
  }

  addToDo(Map body) async {
    await supabase.from("to_do").insert(body).select();
  }

  // editComplete({required int id, required bool newValue}) async {
  //   await supabase.from("to_do").update({"complete": newValue}).eq("id", id);
  // }

  deleteToDo({required int id}) async {
    await supabase.from("to_do").delete().eq('id', id);
  }
}
