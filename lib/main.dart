import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:studentdatabase/Database/model/datamodel.dart';
import 'package:studentdatabase/Screens/splashscreen.dart';

// late Box<StudentModel> studentdataDB;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter();

  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }

  // studentdataDB = await Hive.openBox<StudentModel>('studentlist');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SpalshScreen(),
    );
  }
}
