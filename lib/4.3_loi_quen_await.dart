void main() async {
  try {
    await login(); // dù có await nhưng cũng ko thể catch đc!
  } catch (e) {
    print(e);
  }
}

Future<void> login() async {
  print('login');
  // nếu ko để ý thiếu await ở đây nó cũng tạch
  getMe();
}

Future<void> getMe() async {
  print('getMe');
  throw 'Không thể get me';
}
