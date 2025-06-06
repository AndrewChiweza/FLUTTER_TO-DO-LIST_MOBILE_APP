import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List ToDoList = [];
  //reference the hive box
  final _mybox = Hive.box("mybox");

  //run this method if the app is opened ever first time
  void createInitialData() {
    ToDoList = [
      ["Code Daily", false],
      ["Do Exercise", false],
    ];
  }

  //load data from thge databse
  void loadData() {
    ToDoList = _mybox.get("TODOLIST");
  }

  //update the data to the database
  void updateDatabase() {
    _mybox.put("TODOLIST", ToDoList);
  }
}
