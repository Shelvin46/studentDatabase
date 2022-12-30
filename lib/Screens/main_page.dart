import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentdatabase/Database/dbfunction/function.dart';
import 'package:studentdatabase/Screens/addstudent.dart';

class homeScreen extends StatelessWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Student Details'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Click to Add Student",
                  style: TextStyle(fontSize: 24.0, color: Colors.blue),
                ),
              ),
              ElevatedButton.icon(
                label: Text('Add Students'),
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (contxt) => studentDetails()));
                },
              )
            ]),
      ),
    );
  }
}
