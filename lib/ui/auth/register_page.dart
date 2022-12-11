import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/data/repository/storage_repository.dart';
import 'package:todo_app/ui/widgets/custom_app_bar.dart';
import 'package:todo_app/ui/widgets/custom_button.dart';
import 'package:todo_app/ui/widgets/custom_textfield.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/const.dart';
import 'package:todo_app/utils/text_style.dart';
import 'package:todo_app/utils/utils.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
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
            Text('Register', style: MyTextStyle.boldLato.copyWith(fontSize: 32)),
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
                    hintText: 'Enter your Password',
                    isEnd: false,
                    isPassword: true,
                    isVisibility: true,
                  ),
                  const SizedBox(height: 25),

                  Text('Password', style: MyTextStyle.regularLato),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: _confirmController,
                    hintText: 'Enter your confirm Password',
                    isEnd: true,
                    isPassword: true,
                    isVisibility: true,
                    confirmController: _passwordController,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // REGISTER BUTTON
            CustomButton(
                text: 'Register',
                onPressed: () async {
                  var isValid = formKey.currentState!.validate();
                  if (isValid) {
                    Navigator.pushReplacementNamed(context, loginPage);
                    await StorageRepository.putString(key: CustomFields.userName, value: _usernameController.text);
                    await StorageRepository.putString(key: CustomFields.userPassword, value: _passwordController.text);
                  } else {
                    CustomSnackbar.showSnackbar(context, 'Зlease fill in correctly', SnackbarType.warning);
                  }
                },
                fillColor: true),
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
            CustomButton(text: 'Register with Google', onPressed: () {}, fillColor: false, icon: FontAwesomeIcons.google),
            const SizedBox(height: 10),

            // FACEBOOK
            CustomButton(
              text: 'Register with Facebook',
              onPressed: () {},
              fillColor: false,
              icon: FontAwesomeIcons.facebook,
            ),
            const SizedBox(height: 10),
            // NAVIGATE TO REGISTER
            InkWell(
              onTap: () {
                Navigator.of(context).popAndPushNamed(loginPage);
              },
              child: Center(
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(text: "Already have an account?", style: MyTextStyle.regularLato.copyWith(color: MyColors.hintTextColor, fontSize: 14)),
                  TextSpan(text: ' Login', style: MyTextStyle.regularLato.copyWith(fontSize: 14)),
                ])),
              ),
            )
          ],
        ),
      ),
    );
  }
}
