import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/text_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.onPressed, this.title});
  final VoidCallback? onPressed;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null
          ? Text(
              title!,
              style: MyTextStyle.regularLato.copyWith(fontSize: 20),
            )
          : null,
      centerTitle: true,
      backgroundColor: MyColors.backgroundColor,
      leading: onPressed != null
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: onPressed,
              splashRadius: 25,
            )
          : null,
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
