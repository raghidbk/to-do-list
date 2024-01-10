import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'todo_vew.dart';

const String _baseUrl = 'amjad5501.000webhostapp.com';

class createTask extends StatefulWidget {
  const createTask({super.key});

  @override
  State<createTask> createState() => _createTaskState();
}

class _createTaskState extends State<createTask> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _controllerContent = TextEditingController();
  final TextEditingController _controllerDate = TextEditingController();
  int month = 0;
  int day = 0;

  void update(String text){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  void updateMonth(int m){
    setState(() {
      month = m;
    });
  }
   void updateDay(int d){
    setState(() {
      day = d;
    });
   }

  @override
  void dispose(){
    super.dispose();
    _controllerContent.dispose();
    _controllerDate.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create a task'),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          child: Column(
            children: [
              const SizedBox(height: 10,),
              SizedBox(width: 300, child: TextFormField(
                validator: (value) => (value == null || value.isEmpty) ? 'Please fill in task' : null,
                controller: _controllerContent,
                decoration: const InputDecoration(
                    hintText: 'Enter task',
                    border: OutlineInputBorder()
                ),
              )),
              const SizedBox(height: 10,),
              const Text('Enter Date'),
              const SizedBox(height: 10,),
              DropdownWidget(updateMonth: updateMonth, updateDay: updateDay),
              const SizedBox(height: 10,),
              ElevatedButton(onPressed: (){


                saveTask(update, _controllerContent.text,int.parse(day.toString()),int.parse(month.toString()));

                Navigator.of(context).pop( MaterialPageRoute(
                    builder: (context) => const todovew()
                ));
              },
                child:const Icon(Icons.add)),
              const SizedBox(height: 20,),
              ElevatedButton(onPressed: () {
                Navigator.of(context).pop( MaterialPageRoute(
                    builder: (context) => const todovew()
                )
                );
              }, child: const Icon(Icons.arrow_back)),
            ],
          ),
        ),
      )
    );
  }
}

List<int> months =[
  1,2,3,4,5,6,7,8,9,10,12
];

List<int> days = [
  1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
];

class DropdownWidget extends StatefulWidget {
  const DropdownWidget({super.key, required this.updateMonth, required this.updateDay});
  final Function(int) updateMonth;
  final Function(int) updateDay;

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  int day = 0, month = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      DropdownMenu(width: 300,
          initialSelection: days[0],
          onSelected: (day){
        setState(() {
          widget.updateDay(int as int);
          day = day;
        });
        },
          dropdownMenuEntries: days.map<DropdownMenuEntry<int>>((int day){
            return DropdownMenuEntry(value: day ,label: day.toString());
          }).toList()),
      const SizedBox(height: 10,),
      DropdownMenu(width: 300,
    initialSelection: months[0],
    onSelected: (month){
      setState(() {
        widget.updateMonth(int as int);
        month = month;
      });
    },
    dropdownMenuEntries: months.map<DropdownMenuEntry<int>>((int month){
      return DropdownMenuEntry(value: month, label: month.toString());
      }).toList()),

    ]);
  }
}

void saveTask(Function(String) update, String taskContent, int tday, int tmonth) async{
  try{
    final uri = Uri.https(_baseUrl, 'save.php');
    final response = await http.post( Uri.parse('_baseURL/save.php'),
        headers: <String,String> {'content type' : 'application/json; charset=UTF-8'},
        body: convert.jsonEncode(<String,String>{
          'taksConten' : taskContent , 'tmoth' : tmonth.toString(), 'tday' : tday.toString(),'key' : 'your_key'
        })
    ).timeout(const Duration(seconds: 500));
    if(response.statusCode == 200){
      update(response.body);
    }
  }catch(e){
    update('connection error');
  }
}
