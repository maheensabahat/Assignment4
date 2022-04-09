import 'package:flutter/cupertino.dart';

class Task {
  var docId;
  String name;
  String desc;
  DateTime date;
  bool isDone = false;
  DateTime doneDate = DateTime(1, 1, 1950);

  Task(this.name, this.desc, this.date);

  Map<String, dynamic> toJson() => {
        'name': name,
        'desc': desc,
        'date': date,
        'isDone': isDone,
        'doneDate': doneDate
      };

  Task.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        desc = json['desc'],
        date = json['date'].toDate(),
        isDone = json['isDone'],
        doneDate = json['doneDate'].toDate();

  @override
  String toString() {
    return 'Task{name: $name}';
  }
}
