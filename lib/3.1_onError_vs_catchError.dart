void main() {
  // Thứ nhất, `onError` ko yêu cầu trả về type giống `then`, `catchError` thì cần
  vd1();

  // Thứ 2, `catchError` có param `test`: cho phép chỉ catch những lỗi cần catch
  // vd2();

  // Quan trọng nhất, chỉ nên dùng `onError` khi muốn phân biệt lỗi nào từ Future gốc, lỗi nào từ hàm `then` gây ra
  // vd3();
}

void vd1() {
  // `onError` ko yêu cầu trả về type giống `then`
  getMe().then<int>((value) => 3, onError: (e) => print(e));

  // `catchError` yêu cầu trả về type giống `then`
  getMe().then<int>((value) => 3).catchError((e) => print(e));
}

void vd2() {
  getMe().then<int>((value) => throw const FormatException()).catchError(
    (e) {
      print('handle lỗi ArgumentError');
      return -1;
    },
    test: (error) => error is ArgumentError, // chỉ catch lỗi ArgumentError
  ).catchError(
    (e) {
      print('handle lỗi NullThrownError');
      return -1;
    },
    test: (error) => error is NullThrownError, // chỉ catch lỗi NullThrownError
  );
}

void vd3() {
  getMe().then((value) {
    throw 'Lỗi bên trong then';

    return; // Hỏi nhỏ: tại sao lại cần lệnh return thừa ở đây?
  }, onError: (e) {
    // catch error từ Future gốc
    print('onError: $e');
    throw 'Lỗi bên trong onError';
  }).catchError((e) {
    // catch error từ onError của hàm then
    print('catchError: $e');
  });
}

// Thử thách thử bỏ từ khoá async của hàm này đi rồi đoán output
Future<void> getMe() async {
  throw 'Lỗi: ko thể get me';
}
