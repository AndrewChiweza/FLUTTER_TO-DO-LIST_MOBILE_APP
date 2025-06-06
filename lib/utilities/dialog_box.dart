import 'package:flutter/material.dart';
import 'package:to_do_app/utilities/my_button.dart';

class DialoBox extends StatefulWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialoBox(
      {Key? key,
      required this.controller,
      required this.onSave,
      required this.onCancel})
      : super(key: key);

  @override
  State<DialoBox> createState() => _DialoBoxState();
}

class _DialoBoxState extends State<DialoBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.deepPurple[300],
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //an input box
            TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Add a new task"),
            ),

            //buttons, save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //save button
                MyButton(text: "Save", onPressed: widget.onSave),
                SizedBox(width: 15),
                //cancel button
                MyButton(text: "Cancel", onPressed: widget.onCancel),
              ],
            )
          ],
        ),
      ),
    );
  }
}
