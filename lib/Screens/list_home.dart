import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentdatabase/Database/dbfunction/function.dart';
import 'package:studentdatabase/Database/dbfunction/update.dart';
import 'package:studentdatabase/Database/dbfunction/update.dart';
import 'package:studentdatabase/Database/dbfunction/update.dart';
import 'package:studentdatabase/Database/model/datamodel.dart';
import 'package:studentdatabase/Screens/editing.dart';
import 'package:studentdatabase/main.dart';

class accountScreen extends StatefulWidget {
  const accountScreen({Key? key}) : super(key: key);

  @override
  State<accountScreen> createState() => _accountScreenState();
}

class _accountScreenState extends State<accountScreen> {
  bool searchicon = false;
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: MySearch());
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: studentListNotifer,
        builder: (BuildContext context, List<StudentModel> studentList,
            Widget? child) {
          return Card(
            elevation: 50.0,
            shadowColor: Colors.black,
            child: ListView.separated(
              itemBuilder: (context, index) {
                final data = studentList[index];
                return Container(
                  height: 80,
                  child: ListTile(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              eachStudentListView(index: index)),
                    ),
                    title: Text(data.name.toUpperCase()),
                    subtitle: Wrap(
                      children: [
                        Text(data.age),
                      ],
                    ),
                    leading: CircleAvatar(
                      backgroundImage: data.image == 'assets/images/default.jpg'
                          ? AssetImage('assets/images/default.jpg')
                              as ImageProvider
                          : FileImage(File(data.image.toString())),
                      radius: 30,
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        showAlertDialog(context, index);
                      },
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 2,
                  color: Colors.grey,
                );
              },
              itemCount: studentList.length,
            ),
          );
        },
      ),
    );
  }

  showAlertDialog(BuildContext contxt, var index) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget okButton = ElevatedButton(
      child: Text("Ok"),
      onPressed: () {
        deleteStudent(index);
        ScaffoldMessenger.of(contxt).showSnackBar(const SnackBar(
            backgroundColor: Colors.blue,
            margin: EdgeInsets.all(20),
            behavior: SnackBarBehavior.floating,
            content: Text("Item deleted Successfully"),
            duration: Duration(seconds: 2)));
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Do you Want to Delete ?"),
      actions: [
        cancelButton,
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class MySearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final studentList = query.isEmpty
        ? studentListNotifer.value
        : studentListNotifer.value
            .where((element) => element.name
                .toLowerCase()
                .startsWith(query.toLowerCase().toString()))
            .toList();

    return studentList.isEmpty
        ? const Center(child: Text("No Data Found!"))
        : ListView.builder(
            itemCount: studentList.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.only(left: 15.00, right: 15.00),
                  child: Column(
                    children: [
                      ListTile(
                        leading: getimage(studentList[index]),
                        title: Text(studentList[index].name),
                        subtitle: Text(
                            "Age : ${(studentList[index].age.toString())}"),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => eachStudentListView(
                                index: index,
                              ),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        thickness: 3,
                        color: Colors.grey,
                      ),
                    ],
                  ));
            });
  }
}

getimage(index) {
  if (index.image == 'assets/images/default.jpg') {
    return const CircleAvatar(
      backgroundImage: AssetImage('assets/images/default.jpg'),
    );
  } else {
    return CircleAvatar(
      // backgroundImage: ,
      backgroundImage: FileImage(File(index.image)),
    );
  }
}
