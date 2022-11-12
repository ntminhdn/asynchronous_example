void main() async {
  // nó cũng giống hàm `catchError`
  try {
    await getMe();
  } on ArgumentError catch (e) {
    print('handleArgumentError $e');
  } on FormatException catch (e) {
    print('handleFormatException $e');
  }
}

Future<String> getMe() async {
  throw ArgumentError('Không thể get me');

  return 'me';
}
