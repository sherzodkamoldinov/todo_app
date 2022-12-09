import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/ui/widgets/custom_app_bar.dart';
import 'package:todo_app/ui/widgets/custom_button.dart';
import 'package:todo_app/ui/widgets/custom_textfield.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/text_style.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: CustomAppBar(onPressed: () {
        Navigator.pop(context);
      }),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TITLE
            Text('Login', style: MyTextStyle.boldLato.copyWith(fontSize: 32)),
            const SizedBox(height: 30),

            // TEXT FIELDS
            Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // USERNAME
                  Text('Username', style: MyTextStyle.regularLato),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: _usernameController,
                    hintText: 'Enter your Username',
                    isEnd: false,
                    isPassword: false,
                  ),
                  const SizedBox(height: 25),

                  // PASSWORD
                  Text('Password', style: MyTextStyle.regularLato),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: 'Enter your Username',
                    isEnd: true,
                    isPassword: true,
                    isVisibility: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // LOGIN BUTTON
            CustomButton(text: 'Login', onPressed: () {}, fillColor: true),
            const SizedBox(height: 40),

            // OR REGISTER WITH ANTHER LINK
            Row(
              children: [
                const Expanded(
                  child: Divider(
                    color: MyColors.borderColor,
                    endIndent: 5,
                  ),
                ),
                Text(
                  'or',
                  style: MyTextStyle.regularLato,
                ),
                const Expanded(
                  child: Divider(
                    indent: 5,
                    color: MyColors.borderColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // GOOGLE
            CustomButton(text: 'Login with Google', onPressed: () {}, fillColor: false, icon: FontAwesomeIcons.google),
            const SizedBox(height: 10),

            // FACEBOOK
            CustomButton(
              text: 'Login with Google',
              onPressed: () {},
              fillColor: false,
              icon: FontAwesomeIcons.facebook,
            ),
            const SizedBox(height: 10),
            // NAVIGATE TO REGISTER
            InkWell(
              onTap: (){},
              child: Center(
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(text: "Don’t have an account?", style: MyTextStyle.regularLato.copyWith(color: MyColors.hintTextColor, fontSize: 14)),
                  TextSpan(text: ' Register', style: MyTextStyle.regularLato.copyWith(fontSize: 14)),
                ])),
              ),
            )
          ],
        ),
      ),
    );
  }
}
