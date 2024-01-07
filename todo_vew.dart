import 'package:flutter/material.dart';
import 'package:to_do_list/main.dart';
import 'package:to_do_list/tasks.dart';
import 'create_task.dart';
import 'main.dart';
class todovew extends StatefulWidget {
  const todovew({super.key});

  @override
  State<todovew> createState() => _todovewState();
}
class _todovewState extends State<todovew> {
  bool darck = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("your tasks"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push( MaterialPageRoute(
                builder: (context) => const createTask()
            )
            );
          }, icon: const Icon(Icons.add)),
        ],
      ),
      body:
      Center(
        child: Column(
          children: [
            showTasks()
          ],
        ),
      ),
    );
  }
}
