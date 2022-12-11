import 'package:flutter/material.dart';
import 'package:todo_app/ui/widgets/custom_app_bar.dart';
import 'package:todo_app/utils/colors.dart';

class FocusPage extends StatefulWidget {
  const FocusPage({super.key});

  @override
  State<FocusPage> createState() => _FocusPageState();
}

class _FocusPageState extends State<FocusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: const CustomAppBar(title: 'Focus Page'),
      body: SizedBox(),
    );
  }
}