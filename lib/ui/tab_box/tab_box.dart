import 'package:flutter/material.dart';
import 'package:todo_app/ui/calendar_page.dart';
import 'package:todo_app/ui/focus_page.dart';
import 'package:todo_app/ui/home_page/home_page.dart';
import 'package:todo_app/ui/home_page/widgets/bottom_navigator_bar.dart';
import 'package:todo_app/ui/profile_page/profile_page.dart';

class TabBox extends StatefulWidget {
  const TabBox({super.key});

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  int currentPage = 0;

  List<Widget> pages = [
    const HomePage(),
     const CalendarPage(),
    const FocusPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: CustomBottomNavigatorBar(
        onTap: (value) {
          setState(() {
            currentPage = value;
          });
        },
        currentIndex: currentPage,
      ),
    );
  }
}
