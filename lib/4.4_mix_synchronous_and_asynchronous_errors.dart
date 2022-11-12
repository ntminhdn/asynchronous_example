import 'dart:io';

void main() {
  // mặc dù đã catch nhưng vẫn crash bởi vì nó là 1 sync function, ko phải async function nên catchError ko thể bắt
  readFile().catchError((e) {
    print('catchError $e');
    return '';
  });
}

// fix: bọc nội dung hàm này bởi Future.sync
Future<String> readFile() {
  final file = createNewFile(); // Throw synchronous error
  return file.readAsString().then((contents) {
    throw 'can not read'; // Throw asynchronous error

    return contents;
  });
}

File createNewFile() {
  throw 'File not found';

  return File('example.txt');
}
