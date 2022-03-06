import 'dart:ui';
import 'package:assignment_4/Clock.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'CreateTask.dart';
import 'TaskDetails.dart';
import 'TaskList.dart';
import 'Task.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => taskList(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Icon(Icons.event_note_outlined),
        title: Text('My Tasks'),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Clock(),
            ),
            Consumer<taskList>(builder: (context, tasks, child) {
              //following used widgets are defined after this class
              return tasks.tasklist.isEmpty ? NoTasks() : Tasks();
            }),
          ],
        ),
      ),
      floatingActionButton:
          Consumer<taskList>(builder: (context, tasks, child) {
        return !tasks.tasklist.isEmpty
            ? FloatingActionButton(
                backgroundColor: Colors.black,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => create_task(),
                  ));
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )
            : Container();
      }),
    );
  }
}

class NoTasks extends StatelessWidget {
  const NoTasks({Key? key}) : super(key: key);

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
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Text(
                  "You have no pending tasks.",
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w800,
                      fontSize: 14),
                ),
              ),
              ElevatedButton(
                child: Text("Add a new task"),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => create_task()));
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    textStyle:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  final List colors = [
    Color(0x4dffc09f),
    Color(0x80ffee93),
    Color(0xacfcf5c7),
    Color(0x4da0ced9),
    Color(0x4dadf7b6),
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
            padding: EdgeInsets.all(24.0),
            itemCount: tasks.tasklist.length,
            itemBuilder: (context, index) => Container(
              margin:
                  const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 16),
              decoration: BoxDecoration(
                  color: colors[index % colors.length],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 4,
                      spreadRadius: 2,
                      offset: Offset(4, 4),
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
                  trailing:
                      tasks.tasklist[index].date.compareTo(DateTime.now()) < 0
                          ? Container(
                              width: 12,
                              decoration: const BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(5),
                                      bottomRight: Radius.circular(5))),
                            )
                          : null,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
