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
                backgroundColor: const Color(0xffb1f3de),
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
                        SizedBox(
                          width: 120,
                          child: ElevatedButton(
                            style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Color(0xffffd388)),
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
                                controller1.text = "";
                                controller2.text = "";
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                        elevation: 50,
                                        backgroundColor: Color(0xffffd388),
                                        content: Text(
                                          "Please insert all fields",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                        )));
                              }
                            },
                            child: const Text(
                              "ADD",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
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
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 239, 146),
            borderRadius: BorderRadius.circular(25)),
        height: 120,
        width: 360,
        child: const Text(
          "add new task",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
