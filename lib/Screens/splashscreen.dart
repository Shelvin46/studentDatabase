import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentdatabase/Screens/bottompage.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({Key? key}) : super(key: key);

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override
  void initState() {
    login();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.asset(
        'assets/images/student.png',
        height: 600,
      )),
      backgroundColor: Colors.white,
    );
  }

  @override
  login() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (contxt) => homepage()));
  }
}
