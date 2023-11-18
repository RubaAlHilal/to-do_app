// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:to_do_with_database/components/card_widget.dart';
import 'package:to_do_with_database/model/to_do_model.dart';
import 'package:to_do_with_database/services/supabase_methods.dart';

import '../components/add_button.dart';
import '../components/refresh_button.dart';

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dDay = DateTime.now().day;
    var dmonth = DateTime.now().month;
    var dhour = DateTime.now().hour;

    return Scaffold(
      backgroundColor: const Color(0xff278e8d),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "To-do App",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: Row(
          children: [
            const SizedBox(
              width: 18,
            ),
            RefreshButton(
              refresh: () {
                setState(() {});
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 20,
                ),
                dhour < 12
                    ? const Text(
                        "Good Morning 🌅",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )
                    : const Text(
                        "Good Evening 🌃",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "Today, ${dDay}/${dmonth}",
                  style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AddButton(
                      controller1: titleController,
                      controller2: descriptionController),
                ],
              ),
            ),
            FutureBuilder(
                future: supabaseMethods.getToDo(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      );
                    } else {
                      final List<ToDoModel> list = snapshot.data!;
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: list.length,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: CardWidget(
                              textEntry1: list[index].title.toString(),
                              textEntry2: list[index].description.toString(),
                              deleteAction: () {
                                supabaseMethods.deleteToDo(
                                    id: list[index].id!.toInt());
                                context
                                    .findAncestorStateOfType<
                                        _HomeScreenState>()!
                                    .setState(() {});
                              },
                              todo: list[index].complete,
                            ),
                          );
                        }),
                      );
                    }
                  } else {
                    if (snapshot.hasError) {
                      print(snapshot.hasError.toString());
                      return Center(child: Text(snapshot.hasError.toString()));
                    }
                    return const Center(
                      child: Text("no tasks added add your first task now!"),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
