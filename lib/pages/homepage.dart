import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/data/database.dart';
import 'package:to_do_app/utilities/dialog_box.dart';
import 'package:to_do_app/utilities/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference the hive box
  final _mybox = Hive.box("mybox");

  @override
  void initState() {
    // if this is the first time opening the app, then create the dafault data
    if (_mybox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      //the data already exists
      db.loadData();
    }
    super.initState();
  }

  //text controller
  final _controller = TextEditingController();
  ToDoDatabase db = ToDoDatabase();

  //checked Box was tapped
  void checkedBoxChanged(bool? value, int index) {
    setState(() {
      db.ToDoList[index][1] = !db.ToDoList[index][1];
    });
    db.updateDatabase();
  }

  //save new task method
  void saveNewTask() {
    setState(() {
      db.ToDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  //add new tasks method
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialoBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  //delete task method
  void deleteTask(int index) {
    setState(() {
      db.ToDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Center(
            child: Text(
          "TO-DO",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        )),
        elevation: 1,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.black,
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.ToDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.ToDoList[index][0],
            onChanged: (value) => checkedBoxChanged(value, index),
            taskCompleted: db.ToDoList[index][1],
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
