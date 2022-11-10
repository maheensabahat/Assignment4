import 'dart:ui';
import 'package:flutter/material.dart';
import 'Task.dart';
import 'package:provider/provider.dart';
import 'TaskList.dart';
import 'package:intl/intl.dart';

class create_task extends StatefulWidget {
  bool canEdit;
  late Task t;

  create_task({Key? key, required this.canEdit}) : super(key: key);

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
  void initState() {
    // TODO: implement initState
    super.initState();

    //Update Task Screen
    if (widget.canEdit) {
      name.text = widget.t.name;
      desc.text = widget.t.desc;

      datePicked = widget.t.date;
      var formatter = new DateFormat('dd MMM y, EEEE');
      date.text = formatter.format(widget.t.date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (widget.canEdit) {
              Navigator.of(context).pop(widget.t);
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //Header
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 24, bottom: 8),
            child: !widget.canEdit
                ? const Text(
                    "New Task",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 25),
                  )
                : const Text(
                    "Edit Task",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 25),
                  ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 24, bottom: 36),
            child: !widget.canEdit
                ? const Text(
                    "Add a new task to your task list.",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  )
                : const Text(
                    "Make changes to tasks in you task list.",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
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
                    Padding(
                      padding: const EdgeInsets.only(left: 24, bottom: 56),
                      child: !widget.canEdit
                          ? const Text(
                              "Enter the task details:",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16),
                            )
                          : const Text(
                              "The task details:",
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
                        cursorColor: Colors.black,
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
                        cursorColor: Colors.black,
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
                        cursorColor: Colors.black,
                      ),
                    ),

                    //Add or Update Button
                    RaisedButton(
                      onPressed: () async {
                        //to check if fields are filled
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
                          //Add or Update Task
                          if (widget.canEdit) {
                            Task t = await Provider.of<taskList>(context,
                                    listen: false)
                                .updateTask(widget.t, name.text, desc.text,
                                    datePicked) as Task;
                            Navigator.of(context).pop(t);
                          } else {
                            new_task = Task(name.text, desc.text, datePicked);
                            Provider.of<taskList>(context, listen: false)
                                .addTask(new_task);
                            Navigator.of(context).pop();
                          }
                        }
                      },
                      //Update or Add Text
                      child: !widget.canEdit
                          ? const Text(
                              'Add Task',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w800),
                            )
                          : const Text(
                              'Update',
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
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold) // button text color
                  ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      var formatter = DateFormat('dd MMM y, EEEE');
      date.text =
          formatter.format(picked.add(const Duration(hours: 23, minutes: 55)));
      datePicked = picked.add(const Duration(hours: 23, minutes: 55));
    } else {
      date.text = "";
    }
  }
}
