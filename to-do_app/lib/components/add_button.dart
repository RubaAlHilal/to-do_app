import 'package:flutter/material.dart';
import 'package:to_do_with_database/services/supabase_methods.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
    required this.controller1,
    required this.controller2,
    // required this.controller3,
  });

  final TextEditingController controller1, controller2;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            useSafeArea: true,
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 250,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextField(
                          controller: controller1,
                          decoration:
                              const InputDecoration(label: Text("title")),
                        ),
                        TextField(
                          controller: controller2,
                          decoration:
                              const InputDecoration(label: Text("description")),
                        ),
                        ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.amber),
                          ),
                          onPressed: () {
                            if (controller1.text.isNotEmpty &&
                                controller2.text.isNotEmpty) {
                              SupabaseMethods().addToDo({
                                "title": controller1.text,
                                "description": controller2.text,
                                "complete": false,
                              });
                              const CircularProgressIndicator();

                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                      elevation: 50,
                                      backgroundColor: Colors.blue,
                                      content: Text(
                                        "Please insert all fields",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      )));
                            }
                          },
                          child: const Text("ADD"),
                        ),
                      ],
                    ),
                  ),
                ),
                title: const Text("Add New Task"),
              );
            });
        // Navigator.pop(context);
      
      },
      child: Container(
        color: Colors.transparent,
        child: const Icon(Icons.note_add_outlined),
      ),
    );
  }
}
