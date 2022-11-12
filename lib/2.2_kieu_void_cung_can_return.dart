void main() {
  // warning vì return type của `then` và `catchError` ko giống nhau
  // `then` đang trả về Future<Null>, còn `catchError` đang trả về Future<void>
  getMe().then((value) {
    // thêm return trước lệnh print là fix được
    print(value);
  }).catchError((e) => print(e));

  // giải thích: do cách đoán kiểu của lambda. Xem runtimeType của 3 lambda sau đây
  final nullLambda = () {
    print('me');
  };

  final voidLambda = () => print('me');
  final voidLambda2 = () {
    return print('me');
  };

  print('nullLambda: ${nullLambda.runtimeType}');
  print('voidLambda: ${voidLambda.runtimeType}');
  print('voidLambda2: ${voidLambda2.runtimeType}');
}

Future<String> getMe() async {
  throw 'error';

  return 'me';
}