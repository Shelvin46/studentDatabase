import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentdatabase/Screens/addstudent.dart';
import 'package:studentdatabase/Screens/list_home.dart';
import 'package:studentdatabase/Screens/main_page.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  int currentSelectIndex = 0;

  List pages = [
    const homeScreen(),
    const accountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentSelectIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentSelectIndex,
        onTap: (newIndex) {
          setState(() {
            currentSelectIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add_home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box), label: 'Account'),
        ],
      ),
    );
  }
}
