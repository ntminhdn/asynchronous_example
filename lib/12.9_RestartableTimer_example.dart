import 'dart:async';

import 'package:async/async.dart';

void main() {
  late Timer periodicTimer;
  final timer = RestartableTimer(const Duration(seconds: 5), () {
    print('done after 5s');
    periodicTimer.cancel();
  });

  periodicTimer = Timer.periodic(const Duration(seconds: 1), (t) {
    print(t.tick);
    if (t.tick == 3) {
      print('reset');
      timer.reset();
    }
  });
}
