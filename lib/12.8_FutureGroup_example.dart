import 'package:async/async.dart';

void main() async {
  final futureCom = nauCom();
  final futureCa = chienCa();
  final futureThit = khoThit();

  // Ưu: mình có thể add dần theo thời gian chứ ko cần add đồng thời
  // Nhược: ko có hàm cleanUp
  final futureGroup = FutureGroup();
  futureGroup.add(futureCom);
  await Future.delayed(const Duration(seconds: 1));
  futureGroup.add(futureCa);
  await Future.delayed(const Duration(seconds: 2));
  futureGroup.add(futureThit);
  futureGroup.close();
  futureGroup.future.then((value) => print(value)).catchError((e) => print(e));
}

Future<String> nauCom() async {
  print('vo gạo at ${DateTime.now()}');
  print('bật nút nấu cơm');
  await Future.delayed(const Duration(seconds: 3));
  print('nấu cơm xong at ${DateTime.now()}');

  return 'cơm';
}

Future<String> chienCa() async {
  print('làm sạch cá');
  print('bắt đầu chiên');
  await Future.delayed(const Duration(seconds: 2));
  throw 'error';
  print('chiên cá xong!!');

  return 'cá chiên';
}

Future<String> khoThit() async {
  print('rửa thịt');
  print('ướp thịt');
  await Future.delayed(const Duration(seconds: 1));
  // throw 1;
  print('kho thịt xong!!');

  return 'thịt kho';
}
