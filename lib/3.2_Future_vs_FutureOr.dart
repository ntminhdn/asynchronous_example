import 'dart:async';

void main() async {
  // trước khi có FutureOr, callback trong hàm `then` bắt buộc return 1 Future như này
  final a = await getMe().then((value) => getMe());
  print(a);

  // sau khi có FutureOr, callback trong hàm `then` có thể trả về 1 non-Future như String, int,...
  final b = await getMe().then((value) => 'me');
  print(b);
}

// là union type của bool | Future<bool>
FutureOr<bool> furureOr() {
  return true;
}

// yêu cầu trả về Future<bool> nhưng lại trả về bool gây ra lỗi combine
// Future<bool> future() {
//   return true;
// }

Future<String> getMe() async {
  return 'me';
}
