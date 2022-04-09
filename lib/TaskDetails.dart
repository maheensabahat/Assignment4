import 'dart:ui';
import 'package:flutter/material.dart';
import 'Task.dart';
import 'package:provider/provider.dart';
import 'TaskList.dart';
import 'CreateTask.dart';
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
            child: const Icon(Icons.clear)),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: Column(
          children: <Widget>[
            //Header
            const Padding(
              padding: EdgeInsets.only(top: 50, bottom: 8),
              child: const Icon(Icons.task_alt_outlined,
                  size: 30, color: Colors.grey),
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
              padding: const EdgeInsets.only(bottom: 50),
              child: Text(
                "Following are your '" + widget.task.name + "' details:",
                style: const TextStyle(
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
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Edit Icon
                          RaisedButton(
                            color: const Color(0xffa0ced9),
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                create_task eTask = create_task(canEdit: true);
                                eTask.t = widget.task;
                                return eTask;
                              })).then((value) {
                                widget.task = value;
                                setState(() {});
                              });
                            },
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.edit,
                                  color: Colors.black54,
                                  size: 20,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 4),
                                  child: Text(
                                    'Edit Task',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                          ),

                          //Delete Icon
                          Padding(
                            padding: const EdgeInsets.only(left: 24),
                            child: RaisedButton(
                              onPressed: () async {
                                bool toBeRemoved = false;
                                toBeRemoved = await showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          backgroundColor: Colors.white,
                                          title: const Text('Confirmation',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                          content: Text(
                                              'Do you want to remove ${widget.task.name}?',
                                              style: const TextStyle(
                                                fontSize: 15,
                                              )),
                                          actions: [
                                            FlatButton(
                                              color: Colors.black,
                                              onPressed: () {
                                                Navigator.of(context).pop(true);
                                              },
                                              child: const Text(
                                                'Yes',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            FlatButton(
                                              color: Colors.black,
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(false);
                                              },
                                              child: const Text(
                                                'No',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ));

                                if (toBeRemoved) {
                                  Provider.of<taskList>(context, listen: false)
                                      .removeTask(widget.task);
                                  Navigator.of(context).pop();
                                }
                              },
                              color: const Color(0xffffc09f),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.delete,
                                    color: Colors.black54,
                                    size: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 4),
                                    child: Text('Delete Task',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),

                      //Task Name
                      Padding(
                        padding: const EdgeInsets.only(top: 48, bottom: 24),
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
                          style: const TextStyle(
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
                            : Container(
                                width: 120,
                                height: 30,
                                child: RaisedButton(
                                  onPressed: () {
                                    Provider.of<taskList>(context,
                                            listen: false)
                                        .MarkDone(widget.task);
                                    setState(() {});
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 4.0),
                                        child: Text('Mark done'),
                                      ),
                                    ],
                                  ),
                                  textColor: Colors.white,
                                  color: Colors.green,
                                ),
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
