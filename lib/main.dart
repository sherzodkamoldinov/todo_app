import 'package:flutter/material.dart';
import 'package:todo_app/data/repository/storage_repository.dart';
import 'package:todo_app/ui/router.dart';
import 'package:todo_app/utils/const.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageRepository.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Todo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: MyRouter.generateRoute,
      initialRoute: splashPage,
    );
  }
}
