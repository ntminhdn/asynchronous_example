void main() {
  // method1();
  // method2();
  method3();
}

void method1() {
  List<String> myArray = <String>['a', 'b', 'c'];
  printT('before loop');
  myArray.forEach((String value) async {
    await delayedPrint(value);
  });
  // hàm forEach ở trên tương đương code này nên 3 Future chạy song song
  // final void Function(String) action = (value) async {
  //   await delayedPrint(value);
  // };
  // action(myArray[0]);
  // action(myArray[1]);
  // action(myArray[2]);
  printT('end of loop');
}

void method2() async {
  List<String> myArray = <String>['a', 'b', 'c'];
  printT('before loop');
  for (int i = 0; i < myArray.length; i++) {
    await delayedPrint(myArray[i]);
  }
  // for loop ở trên tương đương code này nên 3 Future chạy tuần tự
  // await delayedPrint(myArray[0]);
  // await delayedPrint(myArray[1]);
  // await delayedPrint(myArray[2]);
  printT('end of loop');
}

void method3() async {
  List<String> myArray = <String>['a', 'b', 'c'];
  printT('before loop');
  await Future.forEach(myArray, (e) {
     // Nếu như có async/await nó sẽ giống method2, ngược lại giống method1
     delayedPrint(e); 
  });
  printT('end of loop');
}

Future<void> delayedPrint(String value) async {
  await Future.delayed(const Duration(seconds: 1));
  printT('delayedPrint: $value');
}

void printT(String text) {
  print('${DateTime.now()}: $text');
}