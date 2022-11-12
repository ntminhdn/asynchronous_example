import 'dart:isolate';

import 'package:flutter/material.dart';

void main(List<String> args) async {
  final receivePort = ReceivePort();
  final isolate = await Isolate.spawn(
    heavyTask,
    [receivePort.sendPort, 100],
  );

  receivePort.listen((message) {
    print(message);
    receivePort.close();
    isolate.kill();
  });
  
  runApp(const MaterialApp(
      home: Scaffold(
    body: Center(
      child: CircularProgressIndicator(),
    ),
  )));
}

Future<void> heavyTask(List<Object> input) async {
  final sendPort = input[0] as SendPort;
  final seed = input[1] as int;
  var counting = seed;
  await Future(() {
    for (var i = 1; i <= 10000000000; i++) {
      counting = i;
    }
  });
  sendPort.send('$counting!');
}
