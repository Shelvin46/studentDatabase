import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studentdatabase/Database/dbfunction/function.dart';
import 'package:studentdatabase/Database/model/datamodel.dart';
import 'package:studentdatabase/Screens/editing.dart';

final ImagePicker picker = ImagePicker();
XFile? imagefile;

class studentDetails extends StatefulWidget {
  studentDetails({Key? key}) : super(key: key);

  @override
  State<studentDetails> createState() => _studentDetailsState();
}

final scaffoldKey = GlobalKey<ScaffoldState>();

class _studentDetailsState extends State<studentDetails> {
  @override
  void initState() {
    imagefile = null;
    super.initState();
  }

  final studentNameCntrl = TextEditingController();
  final studentAgeCntrl = TextEditingController();
  final studentCourseCntrl = TextEditingController();
  final studentYearCntrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Details'),
      ),
      key: scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundImage: imagefile != null
                        ? FileImage(File(imagefile!.path)) as ImageProvider
                        : AssetImage('assets/images/default.jpg'),
                    radius: MediaQuery.of(context).size.width * 0.2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 80.0, top: 70),
                      child: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: ((builder) => BottomSheet()),
                          );
                        },
                        icon: const Icon(Icons.add_a_photo_rounded),
                        color: Colors.white,
                        iconSize: 40,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 50.0,
                  ),
                ),
                TextField(
                  controller: studentNameCntrl,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Name of Student'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: studentAgeCntrl,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Age'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: studentCourseCntrl,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Course'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: studentYearCntrl,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Year'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 100)),
                    ElevatedButton.icon(
                      onPressed: () {
                        addRequiredField(context);
                      },
                      icon: const Icon(Icons.check_outlined),
                      label: const Text('Submit'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addRequiredField(BuildContext contxt) async {
    // final studentImage = imagefile!.path.toString();
    final studentName = studentNameCntrl.text.trim();
    final studentAge = studentAgeCntrl.text.trim();
    final studentCourse = studentCourseCntrl.text.trim();
    final studentYear = studentYearCntrl.text.trim();
    String studentImage;

    if (imagefile != null) {
      studentImage = imagefile!.path.toString();
    } else {
      studentImage = 'assets/images/default.jpg';
    }

    if (studentName.isEmpty ||
        studentAge.isEmpty ||
        studentCourse.isEmpty ||
        studentYear.isEmpty ||
        studentImage.isEmpty) {
      ScaffoldMessenger.of(contxt).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
          content: Text("All feild are Required"),
          duration: Duration(seconds: 2)));
      return;
    } else {
      ScaffoldMessenger.of(contxt).showSnackBar(const SnackBar(
        backgroundColor: Colors.blue,
        margin: EdgeInsets.all(20),
        behavior: SnackBarBehavior.floating,
        content: Text("Added Succesfully"),
        duration: Duration(seconds: 2),
      ));

      Navigator.pop(contxt);
    }

    final student = StudentModel(
        image: studentImage,
        name: studentName,
        age: studentAge,
        course: studentCourse,
        year: studentYear);

    addStudent(student);
  }

  Widget BottomSheet() {
    scaffoldKey.currentState;
    // scaffoldKey.currentState!
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose Profile Photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              const SizedBox(
                width: 40,
              ),
              IconButton(
                icon: const Icon(Icons.image_search),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
              const Text('Gallery'),
              const SizedBox(
                width: 50,
              ),
              IconButton(
                icon: const Icon(Icons.camera),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
              const Text('Camera'),
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource src) async {
    XFile? PickedFile = await ImagePicker().pickImage(source: src);
    setState(() {
      imagefile = PickedFile;
    });
  }
}
