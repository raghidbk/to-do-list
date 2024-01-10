import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String _baseURL = 'raghidscsci.000webhostapp.com';

class task {
  int _tid;
  String _taskContent;
  int _tday;
  int _tmonth;


  task(this._tid, this._taskContent, this._tday, this._tmonth);

  @override
  String toString() {
    return '$_taskContent\n due on\$$_tday/$_tmonth';
  }
}

List<task> _tasks = [];

void updateTasks(Function(bool success) update) async {
  try {
    final url = Uri.https(_baseURL, 'getTasks.php');
    final response = await http.get(url)
        .timeout(const Duration(seconds: 5));
    _tasks.clear();
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      for (var row in jsonResponse) {
        task p = task(
            int.parse(row['tid']),
            row['taskContent'],
            row['tday'],
            row['tmonth']);
        _tasks.add(p);
      }
      update(true);
    }
  }
  catch(e) {
    update(false);
  }
}

// shows products stored in the _products list as a ListView
class showTasks extends StatelessWidget {

  const showTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) => Column(children: [
          const SizedBox(height: 10),
          Container(
              color: index % 2 == 0 ? Colors.amber: Colors.cyan,
              padding: const EdgeInsets.all(5),
              width: width * 0.9, child: Row(children: [
            SizedBox(width: width * 0.15),
            Flexible(child:Row(
              children: [
                Checkbox(value: true, onChanged: (e){
                 //_tasks[index].clear();
                })
              ],
            ))
          ]))
        ])
    );
  }
}
