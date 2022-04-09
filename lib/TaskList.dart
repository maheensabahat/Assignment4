import 'package:flutter/cupertino.dart';
import 'Task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class taskList extends ChangeNotifier {
  List<Task> tasklist = [];
  bool isLoading = true;

  taskList() {
    generateList();
  }

  generateList() async {
    await getTasks();
    isLoading = false;
  }

  //Add Task to Database
  Future<void> addTask(Task task) async {
    tasklist.clear();
    isLoading = true;
    notifyListeners();

    // Call the task's CollectionReference to add a new task
    CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');
    tasks.add(task.toJson()).then((value) {
      print("Task added.");
    }).catchError((error) => print("Failed to add Task: $error"));

    generateList();
  }

  //Retreive from Database
  Future<void> getTasks() async {
    await FirebaseFirestore.instance
        .collection('tasks')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Task t = Task.fromJson(doc.data() as Map<String, dynamic>);
        t.docId = doc.id;
        tasklist.add(t);
      });
    });

    sort();
    notifyListeners();
  }

  //Update Task in Database
  Future<Task> updateTask(
      Task task, String name, String desc, DateTime date) async {
    tasklist.clear();
    isLoading = true;
    notifyListeners();

    CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');

    await tasks.doc(task.docId).update({
      'name': name,
      'desc': desc,
      'date': date,
    }).then((value) {
      print("Task updated.");
    }).catchError((error) => print("Failed to updated Task: $error"));

    await generateList();
    int i = tasklist.indexWhere((element) => element.docId == task.docId);
    return tasklist[i];
  }

  //Delete Task in Database
  Future<void> removeTask(Task task) async {
    tasklist.clear();
    isLoading = true;
    notifyListeners();

    CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');

    await tasks.doc(task.docId).delete().then((value) {
      print("Task deleted.");
      tasklist.remove(task);
    }).catchError((error) => print("Failed to delete Task: $error"));

    await generateList();
  }

  //Mark Tasks Done
  Future<void> MarkDone(Task task) async {
    tasklist.clear();
    isLoading = true;
    notifyListeners();

    task.isDone = !task.isDone;
    if (task.isDone)
      task.doneDate = DateTime.now();
    else {
      task.doneDate = DateTime(1, 1, 1950);
    }
    CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');

    await tasks.doc(task.docId).update(
        {'isDone': task.isDone, 'doneDate': task.doneDate}).then((value) {
      print("Task marked done.");
    }).catchError((error) => print("Failed to mark Task done: $error"));

    await generateList();
  }

  sort() {
    //sorted acc to due date
    Comparator<Task> comparator = (a, b) => a.date.compareTo(b.date);
    tasklist.sort(comparator);

    //done tasks sorted in the order they were done
    comparator = (a, b) => a.doneDate.compareTo(b.doneDate);
    tasklist.sort(comparator);
  }
}
