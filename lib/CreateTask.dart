import 'dart:ui';
import 'package:flutter/material.dart';
import 'Task.dart';
import 'package:provider/provider.dart';
import 'TaskList.dart';
import 'package:intl/intl.dart';

class create_task extends StatefulWidget {
  const create_task({Key? key}) : super(key: key);

  @override
  _create_taskState createState() => _create_taskState();
}

class _create_taskState extends State<create_task> {
  bool _validateN = false;
  bool _validateD = false;
  bool _validateDa = false;
  final TextEditingController name = TextEditingController();
  final TextEditingController desc = TextEditingController();
  final TextEditingController date = TextEditingController();
  late Task new_task;
  late DateTime datePicked;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //Header
          const Padding(
            padding: EdgeInsets.only(top: 16, left: 24, bottom: 8),
            child: Text(
              "New Task",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 25),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 24, bottom: 36),
            child: Text(
              "Add a new task to your task list.",
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w300,
                  fontSize: 15),
            ),
          ),

          //Form
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //
                    const Padding(
                      padding: EdgeInsets.only(left: 24, bottom: 56),
                      child: Text(
                        "Enter the task details.",
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w800,
                            fontSize: 16),
                      ),
                    ),

                    //Name Field
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: TextField(
                        controller: name,
                        style: const TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                                width: 1.0, color: Colors.black),
                          ),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.red)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                  width: 2, color: Colors.black)),
                          labelText: 'Name',
                          labelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          errorText: _validateN ? "*Required" : null,
                          filled: true,
                          fillColor: Colors.black12,
                        ),
                      ),
                    ),

                    //Description field
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: TextField(
                        controller: desc,
                        style: const TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                                width: 1.0, color: Colors.black),
                          ),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.red)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                  width: 2, color: Colors.black)),
                          labelText: 'Description',
                          labelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          errorText: _validateD ? "*Required" : null,
                          filled: true,
                          fillColor: Colors.black12,
                        ),
                      ),
                    ),

                    //Due Date Field
                    Padding(
                      padding: const EdgeInsets.only(bottom: 36),
                      child: TextField(
                        readOnly: true,
                        controller: date,
                        style: const TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                                width: 1.0, color: Colors.black),
                          ),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.red)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                  width: 2, color: Colors.black)),
                          labelText: 'Due Date',
                          labelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          errorText: _validateDa ? "*Required" : null,
                          filled: true,
                          fillColor: Colors.black12,
                          suffixIcon: InkWell(
                            child: const Icon(
                              Icons.calendar_today_outlined,
                              color: Colors.black54,
                            ),
                            onTap: () {
                              _selectDate(context);
                            },
                          ),
                        ),
                      ),
                    ),

                    RaisedButton(
                      onPressed: () {
                        if (name.text.isEmpty ||
                            desc.text.isEmpty ||
                            date.text.isEmpty) {
                          setState(() {
                            name.text.isEmpty
                                ? _validateN = true
                                : _validateN = false;

                            desc.text.isEmpty
                                ? _validateD = true
                                : _validateD = false;

                            date.text.isEmpty
                                ? _validateDa = true
                                : _validateDa = false;
                          });
                        } else {
                          new_task = Task(name.text, desc.text, datePicked);
                          Provider.of<taskList>(context, listen: false)
                              .addTask(new_task);
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text(
                        'Add Task',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w800),
                      ),
                      textColor: Colors.white,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.black, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  primary: Colors.black,
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold) // button text color
                  ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      var formatter = new DateFormat('dd MMM y, EEEE');
      date.text =
          formatter.format(picked.add(const Duration(hours: 23, minutes: 55)));
      datePicked = picked.add(const Duration(hours: 23, minutes: 55));
    } else {
      date.text = "";
    }
  }
}
