import 'package:flutter/material.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/text_style.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key, TextEditingController? confirmController, required TextEditingController controller, required this.isEnd, required this.hintText, required this.isPassword, this.isVisibility})
      : _controller = controller,
        _confirmController = confirmController;
  final TextEditingController _controller;
  final bool isEnd;
  final String hintText;
  final bool isPassword;
  final TextEditingController? _confirmController;
  final bool? isVisibility;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword ? isVisibility! : false,
      style: MyTextStyle.regularLato.copyWith(color: MyColors.fontColor),
      controller: _controller,
      textInputAction: !isEnd ? TextInputAction.next : null,
      cursorColor: MyColors.hintTextColor,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        suffixIcon: isPassword
            ? IconButton(
                onPressed: () {},
                icon: Icon(
                  isVisibility! ? Icons.visibility : Icons.visibility_off,
                  color: MyColors.borderColor,
                ))
            : null,
        hintText: hintText,
        hintStyle: MyTextStyle.regularLato.copyWith(color: MyColors.textFieldColor),
        errorStyle: MyTextStyle.regularLato.copyWith(color: Colors.red),
        fillColor: MyColors.textFieldColor,
        filled: true,
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: MyColors.borderColor, width: 0.8)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: MyColors.borderColor, width: 0.8)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Colors.red, width: 0.8)),
        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Colors.red, width: 0.8)),
      ),
      validator: (value) {
        if (value != null) {
          if (isPassword && value.trim().length < 8) {
            return 'Password should be large then 7';
          } else if (_confirmController != null) {
            if (isEnd && _confirmController!.text.trim() != value.trim()) {
              return 'Password should be mutch';
            }
          } else if (!isPassword && value.trim().isEmpty) {
            return 'Fill currently';
          }
        }
        return null;
      },
    );
  }
}
