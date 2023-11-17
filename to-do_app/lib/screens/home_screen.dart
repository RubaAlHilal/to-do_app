import 'package:flutter/material.dart';
import 'package:to_do_with_database/model/to_do_model.dart';
import 'package:to_do_with_database/services/supabase_methods.dart';

import '../components/add_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SupabaseMethods supabaseMethods = SupabaseMethods();
  TextEditingController titleController = TextEditingController(),
      descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            FutureBuilder(
                future: supabaseMethods.getToDo(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else {
                      final List<ToDoModel> list = snapshot.data!;
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: list.length,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: Card(
                                child: Row(
                                  children: [
                                    Checkbox(
                                        checkColor: Colors.amber,
                                        activeColor: Colors.red,
                                        value: list[index].complete,
                                        onChanged: (value) {
                                          list[index].complete = value!;
                                          // context
                                          //     .findAncestorStateOfType<
                                          //         _HomeScreenState>()!
                                          //     .setState(() {});
                                        }),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(list[index].title.toString()),
                                        Text(
                                          list[index].description.toString(),
                                         
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        supabaseMethods.deleteToDo(
                                            id: list[index].id!.toInt());
                                        setState(() {});
                                      },
                                      icon: const Icon(Icons.delete_outline),
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }));
                    }
                  } else {
                    if (snapshot.hasError) {
                      print(snapshot.hasError.toString());
                      return Text(snapshot.hasError.toString());
                    }
                    return const Text(
                        "no tasks added add your first task now!");
                  }
                }),
            AddButton(
              controller1: titleController,
              controller2: descriptionController,
            ),
          ],
        ),
      ),
    );
  }
}
