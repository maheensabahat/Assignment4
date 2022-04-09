import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'TaskList.dart';
import 'TaskDetails.dart';
import 'package:intl/intl.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  final List colors = [
    const Color(0x4dffc09f),
    const Color(0x80ffee93),
    const Color(0xacfcf5c7),
    const Color(0x4da0ced9),
    const Color(0x4dadf7b6),
  ];
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Consumer<taskList>(builder: (context, tasks, child) {
          return ListView.builder(
            padding: const EdgeInsets.all(24.0),
            itemCount: tasks.tasklist.length,
            itemBuilder: (context, index) => Container(
              margin:
                  const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 16),
              decoration: BoxDecoration(
                  color: colors[index % colors.length],
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 4,
                      spreadRadius: 2,
                      offset: const Offset(4, 4),
                    )
                  ]),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          task_details(task: tasks.tasklist[index])));
                },
                child: ListTile(
                    title: Text(
                      tasks.tasklist[index].name,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "Due: " +
                          DateFormat('dd MMM y, EEEE')
                              .format(tasks.tasklist[index].date),
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    //Mark done
                    leading: InkWell(
                      child: Icon(
                        tasks.tasklist[index].isDone
                            ? Icons.check_circle_sharp
                            : Icons.circle_outlined,
                        color: tasks.tasklist[index].isDone
                            ? Colors.green
                            : Colors.black54,
                      ),
                      onTap: () {
                        Provider.of<taskList>(context, listen: false)
                            .MarkDone(tasks.tasklist[index]);
                      },
                    ),

                    //Delete and banner
                    trailing: Container(
                      width: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          //Delete Icon
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: InkWell(
                              child: const Icon(
                                Icons.delete,
                                color: Colors.black54,
                              ),
                              onTap: () async {
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
                                              'Do you want to remove ${tasks.tasklist[index].name}?',
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
                                      .removeTask(tasks.tasklist[index]);
                                }
                              },
                            ),
                          ),

                          //Banner
                          tasks.tasklist[index].date.compareTo(DateTime.now()) <
                                  0
                              ? Container(
                                  width: 12,
                                  decoration: const BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(5),
                                          bottomRight: Radius.circular(5))),
                                )
                              : Container(
                                  width: 12,
                                ),
                        ],
                      ),
                    )),
              ),
            ),
          );
        }),
      ),
    );
  }
}
