import 'package:flutter/material.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/text_style.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    TextEditingController? confirmController,
    required TextEditingController controller,
    required this.isEnd,
    required this.hintText,
    required this.isPassword,
    this.maxLength,
    required this.isFill,
  })  : _controller = controller,
        _confirmController = confirmController;
  final TextEditingController _controller;
  final bool isEnd;
  final String hintText;
  final bool isPassword;
  final TextEditingController? _confirmController;
  final int? maxLength;
  final bool isFill;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isVisible = true;
  _onPressed() {
    if (widget.isPassword) {
      isVisible = !isVisible;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.maxLength,
      obscureText: widget.isPassword ? isVisible : false,
      style: MyTextStyle.regularLato.copyWith(color: MyColors.fontColor),
      controller: widget._controller,
      textInputAction: !widget.isEnd ? TextInputAction.next : null,
      cursorColor: MyColors.hintTextColor,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: _onPressed,
                icon: Icon(
                  isVisible ? Icons.visibility : Icons.visibility_off,
                  color: MyColors.borderColor,
                ),
              )
            : null,
        hintText: widget.hintText,
        hintStyle: MyTextStyle.regularLato.copyWith(color: widget.isFill ? MyColors.textFieldColor : MyColors.fontColor),
        errorStyle: MyTextStyle.regularLato.copyWith(color: Colors.red),
        fillColor: MyColors.textFieldColor,
        filled: widget.isFill,
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: MyColors.borderColor, width: 0.8)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: MyColors.borderColor, width: 0.8)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Colors.red, width: 0.8)),
        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Colors.red, width: 0.8)),
      ),
      validator: (value) {
        if (value != null) {
          if (widget.isPassword && widget._confirmController == null && value.trim().length < 8) {
            return 'Password should be large then 7';
          } else if (widget._confirmController != null) {
            if (widget.isEnd && widget._confirmController!.text.trim() != value.trim()) {
              return 'Password should be mutch';
            }
          } else if (!widget.isPassword && value.trim().isEmpty) {
            return 'Fill currently';
          }
        }
        return null;
      },
    );
  }
}
