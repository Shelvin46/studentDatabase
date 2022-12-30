import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studentdatabase/Database/dbfunction/function.dart';
import 'package:studentdatabase/Database/model/datamodel.dart';
import 'package:studentdatabase/Screens/addstudent.dart';
import 'package:studentdatabase/main.dart';

final updateNameController = TextEditingController();
final updateAgeController = TextEditingController();
final updateCourseController = TextEditingController();
final updateYearController = TextEditingController();
ImagePicker imagePicker = ImagePicker();
var image;
var index;

Future<void> updateStudent(
    BuildContext context, int index, StudentModel datalist) async {
  updateNameController.text = studentListNotifer.value[index].name;
  updateAgeController.text = studentListNotifer.value[index].age;
  updateCourseController.text = studentListNotifer.value[index].course;
  updateYearController.text = studentListNotifer.value[index].year;

  return showDialog(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: AlertDialog(
              title: Text('Update Student Details'),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                CircleAvatar(
                  backgroundImage: FileImage(File(datalist.image)),
                  radius: 70,
                ),
                TextField(
                  onChanged: (value) {},
                  controller: updateNameController,
                  decoration: InputDecoration(hintText: 'Name'),
                ),
                TextField(
                  onChanged: (value) {},
                  controller: updateAgeController,
                  decoration: InputDecoration(hintText: 'Age'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  // onChanged: (value) {},
                  controller: updateCourseController,
                  decoration: InputDecoration(hintText: 'Course'),
                ),
                TextField(
                  onChanged: (value) {},
                  controller: updateYearController,
                  decoration: InputDecoration(hintText: 'Year'),
                  keyboardType: TextInputType.number,
                ),
                ElevatedButton.icon(
                    onPressed: () async {
                      onClick(context);

                      // showModalBottomSheet(context: context, builder: (context

                      // BottomSheet;
                      // XFile? img = await imagePicker.pickImage(
                      //     source: ImageSource.camera);
                      //     if(img==)
                      // image = img;
                      // studentListNotifer.value[index].image = image;
                      // image = img!.path;
                      // if (img == ) {
                      //   // image = studentListNotifer.value[index].image;
                      // } else {
                      //   image = img.path;
                      // }
                    },
                    icon: Icon(Icons.image),
                    label: Text('Image')),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      onUpdateButtonClicked(index, context);
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.done),
                    label: Text('submit')),
              ])),
        );
      });
}

Future<void> onUpdateButtonClicked(index, context) async {
  final updateName = updateNameController.text.trim();
  final updateAge = updateAgeController.text.trim();
  final updateCourse = updateCourseController.text.trim();
  final updateYear = updateYearController.text.trim();
  String updateImage = image;

  final values = StudentModel(
      name: updateName,
      age: updateAge,
      course: updateCourse,
      year: updateYear,
      image: updateImage);
  updated(values, index);

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.blue,
      margin: EdgeInsets.all(10),
      content: Text('Updated')));
}

Future<void> onClick(BuildContext context) async {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Profile photo',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: IconButton(
                        onPressed: () {
                          updateImage1(ImageSource.gallery);
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.image_search),
                        tooltip: 'folder',
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        updateImage(ImageSource.camera);
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.camera),
                      tooltip: 'camera',
                    )
                  ],
                )
              ],
            ),
          ),
        );
      });
}

updateImage1(ImageSource gallery) async {
  XFile? img = await imagePicker.pickImage(source: ImageSource.gallery);
  if (img == null) {
    image = studentListNotifer.value[index].image;
  } else {
    image = img.path;
  }
}

updateImage(ImageSource camera) async {
  XFile? img = await imagePicker.pickImage(source: ImageSource.camera);
  if (img == null) {
    image = studentListNotifer.value[index].image;
  } else {
    image = img.path;
  }
}
