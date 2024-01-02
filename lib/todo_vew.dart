import 'package:flutter/material.dart';
class todovew extends StatefulWidget {
  const todovew({super.key});

  @override
  State<todovew> createState() => _todovewState();
}

class _todovewState extends State<todovew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("your tasks"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.add)),
        ],
      ),
    );
  }
}
