import 'dart:ui';
import 'package:flutter/material.dart';
import 'Task.dart';
import 'package:provider/provider.dart';
import 'TaskList.dart';
import 'package:intl/intl.dart';

class task_details extends StatefulWidget {
  Task task;

  task_details({Key? key, required this.task}) : super(key: key);

  @override
  task_detailsState createState() => task_detailsState();
}

class task_detailsState extends State<task_details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.clear)),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: Column(
          children: <Widget>[
            //Header
            Padding(
              padding: EdgeInsets.only(top: 50, bottom: 8),
              child:
                  Icon(Icons.task_alt_outlined, size: 30, color: Colors.grey),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                "Task Details",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 25),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: Text(
                "Following are your '" + widget.task.name + "' details:",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                    fontSize: 15),
              ),
            ),

            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Task Name
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Text(
                          widget.task.name,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      //desc
                      Padding(
                        padding: const EdgeInsets.only(bottom: 36),
                        child: Text(
                          widget.task.desc,
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w800,
                              fontSize: 15),
                        ),
                      ),

                      //Due Date
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Due Date: ",
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              DateFormat('dd MMM y, EEEE')
                                  .format(widget.task.date),
                              style: const TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ),

                      //Due Date Msg
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: DateTime.now().compareTo(widget.task.date) > 0
                            ? const Text(
                                "Due Date has passed!",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              )
                            : null,
                      ),

                      //Mark Done
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: widget.task.isDone
                            ? Text(
                                "You marked this task as done on " +
                                    DateFormat('dd MMM y, EEEE')
                                        .format(widget.task.doneDate) +
                                    ".",
                                style: const TextStyle(color: Colors.green),
                              )
                            : RaisedButton(
                                onPressed: () {
                                  // Provider.of<taskList>(context, listen: false)
                                  //     .MarkDone(widget.task);
                                  // setState(() {});
                                  context.read<taskList>().MarkDone(widget.task);
                                  setState(() {

                                  });
                                },
                                child: Text('Mark done'),
                                textColor: Colors.white,
                                color: Colors.green,
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
