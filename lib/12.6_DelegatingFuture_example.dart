import 'package:async/async.dart';

void main() {
  final myFuture = MyCustomFuture(getMe());
  print('isComplete: ${myFuture.isComplete}');
  print(myFuture.result?.asValue?.value);
  Future.delayed(const Duration(seconds: 5), () {
    print('isComplete: ${myFuture.isComplete}');
    print(myFuture.result?.asValue?.value);
  });
}

class MyCustomFuture<T> extends DelegatingFuture<T> {
  MyCustomFuture(Future<T> future) : super(future) {
    Result.capture(future).then((value) {
      print('captured: $value');
      _result = value;
    });
  }

  bool get isComplete => result != null;

  /// The result of the wrapped [Future], if it's completed.
  /// If it hasn't completed yet, this will be `null`.
  Result<T>? get result => _result;
  Result<T>? _result;
}

Future<String> getMe() async {
  print('get me');
  await Future.delayed(const Duration(seconds: 2));

  return 'me';
}
