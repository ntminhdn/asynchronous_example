void main() {
  nauCom();
  khoThit('Thịt gà');
}

Future<void> nauCom() async {
  printT('Bật nút nấu cơm và chờ 3 giây');

  // nấu cơm trong 3 giây
  await Future.delayed(const Duration(seconds: 3));
  printT('Nấu cơm xong!!');
}

Future<void> khoThit(String thit) async {
  // ướp thịt
  final thitDaUop = await uopThit(thit);

  printT('Bắt đầu kho $thitDaUop trong 1 giây');

  // để lửa kho 1 giây
  await Future.delayed(const Duration(seconds: 1));
  printT('Kho $thitDaUop xong!!');
}

Future<String> uopThit(String thitChuaUop) async {
  printT('Uớp $thitChuaUop trong 2 giây');
  // chờ gia vị thấm trong 2 giây
  await Future.delayed(const Duration(seconds: 2));

  return '$thitChuaUop đã ướp';
}

void printT(String text) {
  print('${DateTime.now()}: $text');
}
