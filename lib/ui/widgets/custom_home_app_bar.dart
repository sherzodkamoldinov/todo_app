import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/text_style.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomHomeAppBar({super.key,required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Index',
        style: MyTextStyle.regularLato.copyWith(fontSize: 20),
      ),
      centerTitle: true,
      backgroundColor: MyColors.backgroundColor,
      leading: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: onPressed,
          splashRadius: 25,
        ),
      ),
      actions: [
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.asset('assets/images/avatar.png'),
        ),
        const SizedBox(width: 5)
      ],
      elevation: 0.0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: MyColors.backgroundColor,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 56);
}
