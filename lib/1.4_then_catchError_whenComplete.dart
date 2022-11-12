void main() async {
  print('VD 1: =======');

  // VD 1: Hàm uopThitVoiMuoi complete với 1 value nên hàm khoThit được chạy
  await uopThitVoiMuoi('Thịt bò')
      .then((thitDaUop) => khoThit(thitDaUop), onError: (e) => printT('Exception: $e'))
      .whenComplete(() => printT('Chén Thịt Bò thôi!'));

  print('\nVD 2: =======');

  // VD 2: Hàm uopThitVoiTieu complete với 1 error nên callback onError được gọi
  await uopThitVoiTieu('Thịt gà')
      .then((thitDaUop) => khoThit(thitDaUop), onError: (e) => printT('Exception: $e'))
      .whenComplete(() => printT('Chén Thịt gà thôi!'));

  print('\nVD 3: =======');

  // VD 3: Thử đổi callback onError thành catchError thì kết quả cũng tương tự
  await uopThitVoiTieu('Thịt gà')
      .then((thitDaUop) => khoThit(thitDaUop))
      .catchError((e) => printT('Exception: $e'))
      .whenComplete(() => printT('Chén Thịt gà thôi!'));
}

Future<void> khoThit(String thitDaUop) async {
  printT('Bắt đầu kho $thitDaUop trong 1 giây');

  // để lửa kho 1 giây
  await Future.delayed(const Duration(seconds: 1));
  printT('Kho $thitDaUop xong!!');
}

Future<String> uopThitVoiMuoi(String thitChuaUop) async {
  printT('Uớp $thitChuaUop với muối trong 2 giây');
  // chờ gia vị thấm trong 2 giây
  await Future.delayed(const Duration(seconds: 2));

  return '$thitChuaUop ướp muối';
}

Future<String> uopThitVoiTieu(String thitChuaUop) async {
  printT('Uớp $thitChuaUop với tiêu trong 2 giây');

  throw 'Hết tiêu rồi!';

  return '$thitChuaUop ướp tiêu';
}

void printT(String text) {
  print('${DateTime.now()}: $text');
}
