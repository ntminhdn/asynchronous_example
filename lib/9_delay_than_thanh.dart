import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Scaffold(body: MyApp()),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Lỗi: không thể showDialog trong initState vì initState chưa thể dùng được BuildContext
    // Fix: Đưa nó vào trong Future.delayed(Duration.zero)
    Future.delayed(Duration.zero, () {
      print('showDialog');
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              content: TextButton(
                child: const Text('Lỗi!!'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return SafeArea(
      child: Container(),
    );
  }
}
