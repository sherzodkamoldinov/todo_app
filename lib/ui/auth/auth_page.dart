import 'package:flutter/material.dart';
import 'package:todo_app/ui/widgets/custom_app_bar.dart';
import 'package:todo_app/ui/widgets/custom_button.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/const.dart';
import 'package:todo_app/utils/text_style.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: CustomAppBar(onPressed: () {
        Navigator.pushReplacementNamed(context, onBoardingPage);
      }),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),

            // TITLE
            Text('Welcome to UpTodo', style: MyTextStyle.boldLato.copyWith(fontSize: 32)),
            const SizedBox(height: 30),

            // SUBTITLE
            Text(
              'Please login to your account or create new account to continue',
              style: MyTextStyle.regularLato.copyWith(color: Colors.white.withOpacity(0.67)),
              textAlign: TextAlign.center,
            ),
            const Expanded(child: SizedBox()),

            // BUTTONS
            CustomButton(
                text: 'LOGIN',
                onPressed: () {
                  Navigator.pushNamed(context, loginPage);
                },
                fillColor: true,
                width: double.infinity),
            const SizedBox(height: 20),
            CustomButton(
                text: 'CREATE ACCOUNT',
                onPressed: () {
                  Navigator.pushNamed(context, registerPage);
                },
                fillColor: false,
                width: double.infinity),
          ],
        ),
      ),
    );
  }
}
