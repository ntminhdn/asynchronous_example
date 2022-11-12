void main() {
  // VD 1 cho ta thấy được hàm catchError có thể bắt được tất cả lỗi trong hàm then, catchError và whenComplete được khai báo trước nó chứ ko bắt được lỗi trong các hàm được khai báo sau nó
  // vd1();

  // VD 2 cho ta thấy hàm catchError cũng có thể return 1 value giống hệt hàm then nên hãy cẩn thận
  vd2();
}

void vd1() {
  getMe()
      .then((value) {
        throw 'Lỗi VD1';
      })
      .whenComplete(
          () => print('whenComplete!')) // whenComplete ở trước catchError nên được chạy trước
      .catchError((e) {
        print('catchError: $e');
      })
      .whenComplete(() =>
          throw 'lỗi trong hàm whenComplete'); // catchError sẽ bắt được tất cả lỗi trong hàm then, catchError và whenComplete được khai báo trước nó chứ ko bắt được lỗi trong các hàm được khai báo sau nó
}

void vd2() {
  getMe().then((value) {
    return 'a';
  }).then((value) {
    throw 'Lỗi VD2';
  }).then((value) {
    return 'c';
  }).catchError((e) {
    print('catchError: $e');

    return 'd';
  }).then((value) {
    // in ra chữ 'd' chứ ko phải 'c', bởi vì hàm catchError cũng có thể return value tương tự như hàm then mà ở đây nó được khai báo sau hàm then nên return 'd'
    print(value);
  });
}

Future<String> getMe() async => 'me';
