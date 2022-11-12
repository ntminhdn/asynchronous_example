import 'package:async/async.dart';
import 'package:flutter/material.dart';

/// VD tính năng live search
void main() {
  runApp(const MaterialApp(
      home: Scaffold(
    body: SafeArea(child: SearchPage()),
  )));
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  CancelableOperation<void>? cancellableOperation;
  final _delayTime = const Duration(milliseconds: 1000);
  String visibleText = '';
  final textEditingController = TextEditingController();

  void _start() {
    cancellableOperation = CancelableOperation.fromFuture(
      Future((() async {
        print('LiveSearch: Vẫn chạy dù đã cancel: ${textEditingController.text}');
        await Future.delayed(_delayTime);
      })),
      onCancel: () {
        print('LiveSearch: Canceled');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: textEditingController,
          onChanged: (value) {
            cancellableOperation?.cancel();
            _start();
            cancellableOperation?.value.whenComplete(() {
              setState(() {
                print('LiveSearch: setState visibleText = $value');
                visibleText = value;
              });
            });
          },
        ),
        Text(visibleText),
      ],
    );
  }
}
