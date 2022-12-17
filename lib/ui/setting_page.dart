import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/ui/profile_page/widgets/profile_item.dart';
import 'package:todo_app/ui/widgets/custom_app_bar.dart';
import 'package:todo_app/utils/colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar:  const CustomAppBar(
        title: 'Settings',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
              profileItem(onPressed: () {}, title: 'Change app color', icon: Icons.format_paint_outlined),

              profileItem(onPressed: () {}, title: 'Change app language', icon: FontAwesomeIcons.language),
          ],
        ),
      ),
    );
  }
}