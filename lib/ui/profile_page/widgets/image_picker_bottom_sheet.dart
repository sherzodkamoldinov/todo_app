import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/user_provider.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/text_style.dart';

imagePickerBottomSheet(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    context: context,
    builder: (_) => Container(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 25),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: MyColors.dialogColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text('Change account Image', style: MyTextStyle.regularLato)),
          const SizedBox(height: 8),
          Divider(
            thickness: 1,
            color: MyColors.fontColor,
          ),
          const SizedBox(height: 15),
          ListTile(
            onTap: () async {
              Navigator.pop(_);
              await context.read<UserProvider>().getUserImageFromCamera(context);
            },
            title: Text('Tack Picture', style: MyTextStyle.regularLato),
          ),
          const SizedBox(height: 20),
          ListTile(
            onTap: () async {
              Navigator.pop(_);
              await context.read<UserProvider>().getUserImageFromGallery(context);
            },
            title: Text('Import from Gallery', style: MyTextStyle.regularLato),
          )
        ],
      ),
    ),
  );
}
