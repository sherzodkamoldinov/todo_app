import 'package:flutter/material.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/const.dart';
import 'package:todo_app/utils/icons.dart';
import 'package:todo_app/utils/text_style.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      // Navigator.pushNamed(context, onBoardingPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Image.asset(MyIcons.splash),
        const SizedBox(height: 35),
        Text('TODO APP', style: MyTextStyle.boldLato.copyWith(fontSize: 38, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
