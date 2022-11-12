void main() {
  Future(() {
    print('Future');

    return 0;
  });

  Future.microtask(() {
    print('Future.microtask');

    return 0;
  });

  Future.sync(() {
    print('Future.sync');

    return 0;
  });

  Future.value(() {
    print('Future.value');

    return 0;
  });
}
