import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/repository/storage_repository.dart';
import 'package:todo_app/providers/user_provider.dart';
import 'package:todo_app/ui/profile_page/widgets/image_picker_bottom_sheet.dart';
import 'package:todo_app/ui/profile_page/widgets/profile_item.dart';
import 'package:todo_app/ui/widgets/custom_app_bar.dart';
import 'package:todo_app/ui/widgets/custom_button.dart';
import 'package:todo_app/ui/widgets/custom_textfield.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/const.dart';
import 'package:todo_app/utils/text_style.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController _userNameController;
  late TextEditingController _passwordController;
  late TextEditingController _newPasswordController;

  _init() {
    context.read<UserProvider>().readLocale();
    _userNameController.text = context.read<UserProvider>().userName;
  }

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();
    _newPasswordController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
  }

  _clear() {
    _passwordController.clear();
    _newPasswordController.clear();
  }

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

            // USERNAME
            Center(
              child: Text(context.watch<UserProvider>().userName, style: MyTextStyle.mediumLato.copyWith(fontSize: 20)),
            ),
            const SizedBox(height: 25),

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
            profileItem(
                onPressed: () {
                  Navigator.pushNamed(context, settingsPage);
                },
                title: 'App Settings',
                icon: Icons.settings_outlined),

            const SizedBox(height: 15),
            Text('Account', style: MyTextStyle.regularLato.copyWith(fontSize: 14, color: MyColors.hintTextColor)),
            const SizedBox(height: 7),

            // EDIT NAME
            profileItem(
              onPressed: () {
                showDialog(
                  context: context,
                  useRootNavigator: false,
                  builder: (BuildContext _) => AlertDialog(
                    backgroundColor: MyColors.dialogColor,
                    title: Column(
                      children: [
                        Center(child: Text('Change account name', style: MyTextStyle.regularLato)),
                        const SizedBox(height: 7),
                        const Divider(thickness: 1, color: MyColors.borderColor),
                      ],
                    ),
                    content: SizedBox(
                      height: 43,
                      child: TextField(
                        controller: _userNameController,
                        autofocus: _userNameController.text.isEmpty ? true : false,
                        textInputAction: TextInputAction.next,
                        cursorColor: MyColors.fontColor,
                        style: MyTextStyle.regularLato,
                        decoration: InputDecoration(
                          hintText: 'UserName',
                          hintStyle: MyTextStyle.regularLato.copyWith(color: MyColors.hintTextColor),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: MyColors.borderColor)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: MyColors.dialogColor)),
                        ),
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(_);
                                _userNameController.text = context.read<UserProvider>().userName;
                                setState(() {});
                              },
                              style: TextButton.styleFrom(
                                primary: MyColors.buttonColor,
                              ),
                              child: Text('Cancel', style: MyTextStyle.regularLato.copyWith(color: MyColors.buttonColor)),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: CustomButton(
                              text: 'Edit',
                              onPressed: () async {
                                if (_userNameController.text.trim().isNotEmpty) {
                                  Navigator.pop(_);
                                  debugPrint('USERNAME CHANGED: ${_userNameController.text.trim()}');
                                  await context.read<UserProvider>().changeUserName(_userNameController.text.trim());
                                } else {
                                  Fluttertoast.showToast(msg: 'Please fill this field', backgroundColor: Colors.red);
                                }
                              },
                              fillColor: true,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
              title: 'Change account name',
              icon: FontAwesomeIcons.userAstronaut,
            ),

            // EDIT PASSWORD
            profileItem(
                onPressed: () {
                  showDialog(
                    context: context,
                    useRootNavigator: false,
                    builder: (BuildContext _) => AlertDialog(
                      scrollable: false,
                      backgroundColor: MyColors.dialogColor,
                      title: Column(
                        children: [
                          Center(child: Text('Change account Password', style: MyTextStyle.regularLato)),
                          const SizedBox(height: 7),
                          const Divider(thickness: 1, color: MyColors.borderColor),
                        ],
                      ),
                      content: SizedBox(
                        height: 200,
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                controller: _passwordController,
                                hintText: 'Enter old password',
                                isEnd: false,
                                isPassword: true,
                                isFill: false,
                              ),
                              const SizedBox(height: 10),
                              CustomTextField(
                                controller: _newPasswordController,
                                hintText: 'Entern new password',
                                isEnd: true,
                                isPassword: true,
                                isFill: false,
                              ),
                            ],
                          ),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pop(_);
                                  _clear();
                                },
                                style: TextButton.styleFrom(
                                  primary: MyColors.buttonColor,
                                ),
                                child: Text('Cancel', style: MyTextStyle.regularLato.copyWith(color: MyColors.buttonColor)),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: CustomButton(
                                text: 'Edit',
                                onPressed: () async {
                                  bool isValid = formKey.currentState!.validate();
                                  if (isValid) {
                                    var oldPassword = StorageRepository.getString(CustomFields.userPassword);
                                    if (oldPassword == _passwordController.text.trim()) {
                                      Navigator.pop(_);
                                      debugPrint('USERPASSWORD CHANGED: ${_newPasswordController.text.trim()}');
                                      await context.read<UserProvider>().changeUserPassword(_newPasswordController.text.trim());
                                      _clear();
                                    } else {
                                      Fluttertoast.showToast(msg: 'Old password is wrong');
                                    }
                                  } else {
                                    Fluttertoast.showToast(msg: 'Please fill in currently!', backgroundColor: Colors.red);
                                  }
                                },
                                fillColor: true,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
                title: 'Change account password',
                icon: Icons.vpn_key_outlined),

            // IMAGE PICKER
            profileItem(
              onPressed: () {
                imagePickerBottomSheet(context);
              },
              title: 'Change account Image',
              icon: Icons.camera_alt_outlined,
            ),

            const SizedBox(height: 15),
            Text('Uptodo', style: MyTextStyle.regularLato.copyWith(fontSize: 14, color: MyColors.hintTextColor)),
            const SizedBox(height: 7),
            profileItem(
                onPressed: () {
                  Fluttertoast.showToast(msg: 'still under development');
                },
                title: 'About US',
                icon: FontAwesomeIcons.userNinja),

            profileItem(onPressed: () {
              Fluttertoast.showToast(msg: 'still under development');
            }, title: 'FAQ', icon: CupertinoIcons.exclamationmark_circle),

            profileItem(onPressed: () {
              Fluttertoast.showToast(msg: 'still under development');
            }, title: 'Help & Feedback', icon: Icons.flash_on_outlined),

            profileItem(onPressed: () {
              Fluttertoast.showToast(msg: 'still under development');
            }, title: 'Support US', icon: Icons.favorite_border_rounded),

            profileItem(onPressed: () {
              
            }, title: 'Log out', icon: Icons.logout, isLogOut: true),
          ],
        ),
      ),
    );
  }
}
