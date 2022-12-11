import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late SharedPreferences _pref;
  TextEditingController controller = TextEditingController();
  _init() async {
    _pref = await SharedPreferences.getInstance();
    print('>>>>>GOOOOOOOO');
  }

  String? text;

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        Text('TEXT: ${_pref.getString('text')}'),
        TextField(
          controller: controller,
        ),
        ElevatedButton(
            onPressed: () async {
              await _pref.setString('text', controller.text);
            },
            child: const Text('Press')),
        ElevatedButton(
            onPressed: () async {
              setState(() {
                text = _pref.getString('text');
              });
            },
            child: const Text('Get'))
      ]),
    );
  }
}
