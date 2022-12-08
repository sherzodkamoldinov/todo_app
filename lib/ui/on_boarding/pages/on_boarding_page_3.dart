import 'package:flutter/cupertino.dart';
import 'package:todo_app/utils/icons.dart';
import 'package:todo_app/utils/text_style.dart';

class OnBoardingPageThree extends StatelessWidget {
  const OnBoardingPageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(MyIcons.onBoardingThree, height: 250),
        const SizedBox(height: 50),
        Text('Orgonaize your tasks', style: MyTextStyle.boldLato.copyWith(fontSize: 32)),
        const SizedBox(height: 30),
        Text(
          'You can organize your daily tasks by adding your tasks into separate categories',
          style: MyTextStyle.regularLato,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
