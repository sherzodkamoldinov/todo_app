import 'package:flutter/material.dart';
import 'package:todo_app/data/repository/storage_repository.dart';
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
  bool isLogged = false;
  bool isInitial = false;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
      isInitial = StorageRepository.getBool(CustomFields.isInitial);
      isLogged = StorageRepository.getBool(CustomFields.isLogged);
      debugPrint('>>>>> IS INITIAL : $isInitial\n>>>>> IS LOGGED: $isLogged');
      isLogged
          ? Navigator.pushReplacementNamed(context, tabBox,arguments: 0)
          : isInitial
              ? Navigator.pushReplacementNamed(context, authPage)
              : Navigator.pushReplacementNamed(context, onBoardingPage);
    });
    super.initState();
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
