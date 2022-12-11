import 'package:flutter/material.dart';
import 'package:todo_app/utils/icons.dart';
import 'package:todo_app/utils/text_style.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(MyIcons.homeCheckList),
          const SizedBox(height: 40),
          Text('What do you want to do today?', style: MyTextStyle.regularLato.copyWith(fontSize: 20)),
          const SizedBox(height: 20),
          Text('Tap + to add your tasks', style: MyTextStyle.regularLato), 
        ],
      ),
    );
  }
}
