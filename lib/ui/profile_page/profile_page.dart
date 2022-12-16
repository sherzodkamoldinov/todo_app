import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/user_provider.dart';
import 'package:todo_app/ui/profile_page/widgets/profile_item.dart';
import 'package:todo_app/ui/widgets/custom_app_bar.dart';
import 'package:todo_app/ui/widgets/custom_button.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/text_style.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: const CustomAppBar(title: 'Profile'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // USER IMAGE
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: context.watch<UserProvider>().userImageFile != null
                    ? Image.file(
                        context.watch<UserProvider>().userImageFile!,
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      )
                    : Icon(
                        Icons.account_circle,
                        color: MyColors.fontColor,
                        size: 90,
                      ),
              ),
            ),
            const SizedBox(height: 10),

            // TODOS DONE STATUS
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: MyColors.dialogColor),
                    child: Center(
                      child: Text(
                        '10 Task left',
                        style: MyTextStyle.regularLato.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: MyColors.dialogColor),
                    child: Center(
                      child: Text(
                        '10 Task done',
                        style: MyTextStyle.regularLato.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),

            Text('Settings', style: MyTextStyle.regularLato.copyWith(fontSize: 14, color: MyColors.hintTextColor)),
            const SizedBox(height: 7),
            profileItem(onPressed: () {}, title: 'App Settings', icon: Icons.settings_outlined),

            profileItem(onPressed: () {}, title: 'Change account password', icon: Icons.vpn_key_outlined),

            profileItem(onPressed: () {}, title: 'Change account Image', icon: Icons.camera_alt_outlined),

            const SizedBox(height: 15),
            Text('Uptodo', style: MyTextStyle.regularLato.copyWith(fontSize: 14, color: MyColors.hintTextColor)),
            const SizedBox(height: 7),
            profileItem(onPressed: () {}, title: 'About US', icon: FontAwesomeIcons.userNinja),

            profileItem(onPressed: () {}, title: 'FAQ', icon: CupertinoIcons.exclamationmark_circle),

            profileItem(onPressed: () {}, title: 'Help & Feedback', icon: Icons.flash_on_outlined),

            profileItem(onPressed: () {}, title: 'Support US', icon: Icons.favorite_border_rounded),

            profileItem(onPressed: () {}, title: 'Log out', icon: Icons.logout, isLogOut: true),
          ],
        ),
      ),
    );
  }
}
