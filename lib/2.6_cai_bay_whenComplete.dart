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
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  getMe().catchError((e) async {
                    await showDialog(
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

                    return '';
                  }).whenComplete(() {
                    setState(() {
                      isLoading = false;
                    });
                  });
                }),
          ],
        ),
      ),
    );
  }
}

Future<String> getMe() async {
  await Future.delayed(const Duration(seconds: 2));
  throw 'error';

  return 'me';
}
