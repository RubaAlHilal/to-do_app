// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:to_do_with_database/layout.dart';

class CardWidget extends StatefulWidget {
  CardWidget({
    super.key,
    required this.textEntry1,
    required this.textEntry2,
    required this.deleteAction,
    required this.todo,
  });

  final String textEntry1, textEntry2;
  final Function() deleteAction;
  bool? todo;

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  bool isCheked = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: const Color(0xffb1f3de),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
          child: Row(
            children: [
              Checkbox(
                  checkColor: Colors.white,
                  activeColor: Colors.redAccent,
                  // list[index].complete,
                  value: widget.todo,
                  onChanged: (val) {
                    // SupabaseMethods().editComplete(id: widget.id, newValue: newValue)
                    widget.todo = val!;
                    setState(() {});
                  }),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.textEntry1,
                    overflow: TextOverflow.ellipsis,
                    style: taskTitleFont,
                  ),
                  Text(
                    widget.textEntry2,
                    overflow: TextOverflow.ellipsis,
                    style: taskDescriptionFont,
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: widget.deleteAction,
                icon: const Icon(Icons.close_rounded),
                color: Colors.red,
                iconSize: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
