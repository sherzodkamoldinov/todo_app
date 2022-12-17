import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/user_provider.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/text_style.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomHomeAppBar({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'My Todos',
        style: MyTextStyle.regularLato.copyWith(fontSize: 20),
      ),
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10,top: 5, bottom: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: context.watch<UserProvider>().userImageFile != null
              ? SizedBox(
                  child: Image.file(
                    context.watch<UserProvider>().userImageFile!,
                    fit: BoxFit.cover,
                  ),
                )
              : Icon(
                  Icons.account_circle,
                  color: MyColors.fontColor,
                ),
        ),
      ),
      backgroundColor: MyColors.backgroundColor,
      titleSpacing: 0.0,
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
