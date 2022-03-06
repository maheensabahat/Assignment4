import 'package:flutter/cupertino.dart';
import 'Task.dart';

class taskList extends ChangeNotifier {
  List<Task> tasklist = [];

  addTask(Task task) {
    tasklist.add(task);

    //sorted acc to due date
    Comparator<Task> comparator = (a, b) => a.date.compareTo(b.date);
    tasklist.sort(comparator);

    //done tasks sorted in the order they were done
    comparator = (a, b) => a.doneDate.compareTo(b.doneDate);
    tasklist.sort(comparator);

    notifyListeners();
  }

  MarkDone(Task task) {
    int index = tasklist.indexOf(task);
    if (index >= 0) {
      tasklist[index].isDone = !tasklist[index].isDone;
      if (tasklist[index].isDone)
        tasklist[index].doneDate = DateTime.now();
      else {
        tasklist[index].doneDate = DateTime(1, 1, 1950);
      }
    }

    //sorted acc to due date
    Comparator<Task> comparator = (a, b) => a.date.compareTo(b.date);
    tasklist.sort(comparator);

    //done tasks sorted in the order they were done
    comparator = (a, b) => a.doneDate.compareTo(b.doneDate);
    tasklist.sort(comparator);
    notifyListeners();
  }
}
