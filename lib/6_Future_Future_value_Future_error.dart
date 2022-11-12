void main() {
  vd2();
}

// ví dụ này cho ta thấy rõ sự khác nhau giữa Future() vs Future.value()
void vd1() {
  // Nếu hàm computation truyền vào trả về non-Future
  Future(() {
    // được print ra
    print('Future()');
  });

  // Nếu value truyền vào là 1 non-Future, returned Future sẽ complete với value đó
  // Chú ý value ở đây là 1 Function type nha
  final b = Future.value(() {
    // Dòng này sẽ ko được print ra vì đây là kiểu Future<Null Function()> (function type)
    // thử comment dòng dưới đi là thấy nó ko đc print ra
    print('Future.value()');
  });

  // muốn Future.value() ở trên print ra thì phải gọi hàm call()
  b.then((value) => value.call());
}

void vd2() {
  // Nếu computation truyền vào là 1 Future, returned Future sẽ complete với value or error giống Future đó
  Future(() => Future.value('Future()')).then((value) => print(value));

  // Nếu value truyền vào là 1 Future, returned Future sẽ complete với value or error giống Future đó
  Future.value(Future(() async {
    return 'Future.value()';
  })).then((value) => print(value));
}

Future<int> vd3() {
  return Future<int>.error(const FormatException('wrong format'));
}
