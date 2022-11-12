import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main(List<String> args) async {
  runIsolate();
  runApp(const MaterialApp(
      home: Scaffold(
    body: Center(
      child: CircularProgressIndicator(),
    ),
  )));
}

void runIsolate() async {
  final result = await compute<int, String>(heavyTask, 100);
  print(result);
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
