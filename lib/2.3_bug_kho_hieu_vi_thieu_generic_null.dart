// ignore_for_file: prefer_void_to_null, invalid_return_type_for_catch_error

import 'dart:async';

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
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            if (isLoading) const CircularProgressIndicator(),
            ElevatedButton(
                child: const Text('show Dialog'),
                onPressed: () {
                  getMe().catchError((e) {
                    // ko có generic <String?> là nó ko vào `then` khiến cho loading xoay mãi.
                    return showDialog(
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
                  }).then((value) {
                    setState(() {
                      isLoading = false;
                    });
                    print('vào then: $value');
                  });
                }),
          ],
        ),
      ),
    );
  }

  Future<String?> getMe() async {
    setState(() {
      isLoading = true;
    });
    throw const FormatException();

    return 'me';
  }
}
