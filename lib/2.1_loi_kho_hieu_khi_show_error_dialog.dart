import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Scaffold(body: MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ElevatedButton(
            child: const Text('show Dialog'),
            onPressed: () {
              getMe().catchError((e) {
                // dù thêm async/await vào nó cũng lỗi
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

                // fix bằng cách thêm dòng return này
                // return '';
              });
            }),
      ),
    );
  }
}

Future<String> getMe() async {
  throw 'error';

  return 'me';
}
