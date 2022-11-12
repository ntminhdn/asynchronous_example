import 'dart:async';

void main() {
  vd2();
}

// thứ tự chạy: synchronous code -> micro tasks -> Future
void vd1() {
  print('main: Start!'); // thực thi nó

  Future(() {
    print('Future()');
  });

  // nó sẽ chạy trước Future()
  scheduleMicrotask(() {
    print('scheduleMicrotask');
  });

  // code trong hàm async được chạy đồng bộ
  callApi();

  print('main: End'); // thực thi nó
}

void vd2() {
  // lỗi trong này ko đc catch
  scheduleMicrotask(() {
    throw 'Lỗi trong scheduleMicrotask KO được catch';
  });

  // thực ra bên trong hàm microtask nó sử dụng hàm scheduleMicrotask
  // nhưng khác ở chỗ là lỗi trong hàm này được catch và trả về Future complete với lỗi đó
  Future<void>.microtask(() {
    throw 'Lỗi trong microtask được catch';

    return;
  }).catchError((e) => print(e));
}

Future<bool> callApi() async {
  print('async function');

  return true;
}
