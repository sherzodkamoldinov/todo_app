import 'package:flutter/cupertino.dart';
import 'package:todo_app/utils/icons.dart';
import 'package:todo_app/utils/text_style.dart';

class OnBoardingPageTwo extends StatelessWidget {
  const OnBoardingPageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(MyIcons.onBoardingTwo, height: 250),
        const SizedBox(height: 50),
        Text('Create daily routine', style: MyTextStyle.boldLato.copyWith(fontSize: 32)),
        const SizedBox(height: 30),
        Text(
          'In Uptodo  you can create your personalized routine to stay productive',
          style: MyTextStyle.regularLato,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
