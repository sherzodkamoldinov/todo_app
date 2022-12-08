import 'package:flutter/cupertino.dart';
import 'package:todo_app/utils/icons.dart';
import 'package:todo_app/utils/text_style.dart';

class OnBoardingPageOne extends StatelessWidget {
  const OnBoardingPageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(MyIcons.onBoardingOne, height: 250),
        const SizedBox(height: 50),
        Text('Manage your tasks', style: MyTextStyle.boldLato.copyWith(fontSize: 32)),
        const SizedBox(height: 30),
        Text(
          'You can easily manage all of your daily tasks in DoMe for free',
          style: MyTextStyle.regularLato,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
