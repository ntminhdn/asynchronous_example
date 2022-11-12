void main() async {
  vd3();
}

/// catch được: [b], [c]
/// ko catch được: [a] do nó ko phải là async function, [d] do nó là một nested error (lỗi chồng lỗi)
void vd1() {
  d().catchError(print);
}

/// catch được: [a]
/// ko catch được: [b] do thiếu await, [c] do thiếu await, [d] do nó là một nested error (lỗi chồng lỗi)
void vd2() {
  try {
    d();
  } catch (e) {
    print(e);
  }
}

/// catch được: [a], [b], [c]
/// ko catch được: [d] do nó là một nested error (lỗi chồng lỗi)
void vd3() async {
  try {
    await d();
  } catch (e) {
    print(e);
  }
}

/// đây là sync function, ko phải async function
Future<void> a() => throw 'Lỗi này ko thể catch';

/// đây là async function trả về error
Future<void> b() async => throw 'Lỗi này ko thể catch';

/// Giống [b], đây cũng là async function trả về error
Future<void> c() => errorFuture();

/// Throw 1 Future mà Future đó lại throw lỗi gây ra nested error
Future<void> d() => throw errorFuture();

Future<void> errorFuture() async {
  throw 'Lỗi này không thể catch';
}
