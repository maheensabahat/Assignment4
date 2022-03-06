import 'package:flutter/cupertino.dart';

class Task {
  String _name;
  String _desc;
  DateTime _date;
  bool isDone = false;
  DateTime doneDate = DateTime(1, 1, 1950);

  Task(this._name, this._desc, this._date);

  String get name => _name;

  String get desc => _desc;

  DateTime get date => _date;
}
