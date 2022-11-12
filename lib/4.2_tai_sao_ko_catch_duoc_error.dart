void main() async {
  vd2();
}

/// Không thể catch được vì thiếu từ khoá async & await
/// Đổi qua dùng hàm catchError thì OK!
void vd1() {
  try {
    callApi();
  } catch (e) {
    print(e);
  }
}

/// Không thể catch được vì readFile() ko phải là async function
/// Đổi qua dùng try/catch thì OK!
void vd2() {
  readFile().catchError((e) => print(e));
}

Future<void> callApi() async {
  throw 'Lỗi API';
}

Future<void> readFile() => throw 'File not found';
