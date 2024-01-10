import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:to_do_list/tasks.dart';
import 'dart:convert' as convert;
import 'create_task.dart';

final List<String> _tasks = [];
// domain of your server
const String _baseURL = 'amjad5501.000webhostapp.com';

class todovew extends StatefulWidget {
  const todovew({super.key});

  @override
  State<todovew> createState() => _todovewState();
}

class _todovewState extends State<todovew> {
  bool _load = false;

  void update(bool success) {
    setState(() {
      _load = true; // show product list
      if (!success) { // API request failed
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('failed to load data')));
      }
    });
  }


  @override
  void initState() {
    // update data when the widget is added to the tree the first tome.
    updateTasks(update);
    super.initState();
  }

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
        body: _load ? const ListTasks() : const Center(
            child: SizedBox(width: 100, height: 100, child: CircularProgressIndicator())
        )
    );
  }
}

class ListTasks extends StatelessWidget {
  const ListTasks({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    bool i = false;
    return ListView.builder(
      itemCount: _tasks.length,
      itemBuilder: (context, index) =>
          Column(children: [
            const SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(value: i, onChanged: (bool? value) {
                    i = true;
                    if (i = true) {
                      Text(_tasks[index], style: TextStyle(
                          decoration: TextDecoration.lineThrough));
                    }
                  }),
                  Text(_tasks[index])
                ])
          ]),

    );
  }


  void updateTasks(Function(bool success) update) async {
    try {
      final url = Uri.https(_baseURL, 'getTasks.php');
      final response = await http.get(url)
          .timeout(const Duration(seconds: 500)); // max timeout 5 seconds
      _tasks.clear(); // clear old products
      if (response.statusCode == 200) { // if successful call
        final jsonResponse = convert.jsonDecode(
            response.body); // create dart json object from json array
        for (var row in jsonResponse) { // iterate over all rows in the json array
          _tasks.add(' ${row['taksConten']}  ${row['tday']}  ${row['tmoth']}');
        }
        update(
            true); // callback update method to inform that we completed retrieving data
      }
    }
    catch (e) {
      update(false); // inform through callback that we failed to get data
    }
  }


}