void main() async {
  printT('Bắt đầu nấu');
  final futureCom = nauCom();
  final futureCa = chienCa();
  final futureThit = khoThit();

  final com = await futureCom;
  final caChien = await futureCa;
  final thitKho = await futureThit;
  eat(com, caChien, thitKho);
}

// nếu cơm mất 3 giây
Future<String> nauCom() async {
  await Future.delayed(const Duration(seconds: 3));

  return 'cơm';
}

// chiên cá mất 2 giây
Future<String> chienCa() async {
  await Future.delayed(const Duration(seconds: 2));

  return 'cá chiên';
}

// kho thịt mất 1 giây
Future<String> khoThit() async {
  await Future.delayed(const Duration(seconds: 1));

  return 'thịt kho';
}

void eat(String com, String ca, String thit) {
  printT('Ăn $com $ca $thit thôi!');
}

void printT(String text) {
  print('${DateTime.now()}: $text');
}
