void main() async {
  printT('Bắt đầu nấu');
  final listMonAn = await Future.wait(
    [nauCom(), chienCa(), khoThit()],
    eagerError: false, // false thì nó ko throw lỗi liền, true là nó throw lỗi lập tức
    cleanUp: ((successValue) => print('CleanUp successValue $successValue....')),
  );

  eat(listMonAn[0], listMonAn[1], listMonAn[2]);
}

Future<String> nauCom() async {
  throw 'nồi cơm điện hỏng';
  await Future.delayed(const Duration(seconds: 3));

  return 'cơm';
}

Future<String> chienCa() async {
  printT('Bắt đầu chiên cá');
  await Future.delayed(const Duration(seconds: 2));

  return 'cá chiên';
}

Future<String> khoThit() async {
  printT('Bắt đầu kho thịt');
  await Future.delayed(const Duration(seconds: 1));

  return 'thịt kho';
}

void eat(String com, String ca, String thit) {
  printT('Ăn $com $ca $thit thôi!');
}

void printT(String text) {
  print('${DateTime.now()}: $text');
}
