import 'package:flutter/material.dart';
import 'CreateTask.dart';

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
                      MaterialPageRoute(builder: (context) => create_task(canEdit: false)));
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