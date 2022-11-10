import 'Clock.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'CreateTask.dart';
import 'TaskList.dart';
import 'NoTasks_widget.dart';
import 'Tasks_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

bool shouldUseFirestoreEmulator = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if (shouldUseFirestoreEmulator) {
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  }
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
      title: 'Task Manager',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
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
        leading: const Icon(Icons.event_note_outlined),
        title: const Text('My Tasks'),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: const Clock(),
            ),
            Consumer<taskList>(builder: (context, tasks, child) {
              //wait to retrieve data from the database
              if (tasks.isLoading) {
                return const CircularProgressIndicator(
                  color: Colors.grey,
                );
              } else {
                return tasks.tasklist.isEmpty ? const NoTasks() : const Tasks();
              }
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
                    builder: (context) => create_task(canEdit: false),
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
