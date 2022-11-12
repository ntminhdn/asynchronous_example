import 'dart:async';

void main() {
  final repository = Repository();
  runBlocCatching(action: () async {
    repository.getMe();
  });
}

Future<void> runBlocCatching({
  required Future<void> Function() action,
}) async {
  try {
    await action();
  } catch (e) {
    print(e);
  }
}

class Repository {
  // bỏ từ khoá async đi là hết lỗi. Vì sao?
  Future<void> getMe() async {
    throw const FormatException();
  }
}
