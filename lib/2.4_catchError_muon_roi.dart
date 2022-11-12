void main() {
  Future<Object> future = getMe();

  // BAD: Too late
  Future.delayed(const Duration(milliseconds: 500), () {
    // Fix: đổi future thành getMe() và comment dòng getMe() ở trên lại
    future.then(print).catchError(print);
  });
}

Future<String> getMe() async {
  throw 'catchError bị muộn rồi!';

  return 'me';
}