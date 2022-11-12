import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: MyPage(),
  ));
}

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  bool loading = true;
  String text = "null";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          ElevatedButton(
              child: const Text('Run heavy function'),
              onPressed: () {
                setState(() => loading = true);
                heavyTask(100)
                    .then((value) => setState(() => text = value))
                    .whenComplete(() => setState(() => loading = false));
              }),
          if (loading) const CircularProgressIndicator(),
          Text(text),
        ],
      ),
    ));
  }

  Future<String> heavyTask(int seed) async {
    var counting = seed;
    await Future(() {
      for (var i = 1; i <= 10000000000; i++) {
        counting = i;
      }
    });
    return '$counting!';
  }
}
