import 'package:async/async.dart';

void main() async {
  final result = await Result.capture(getMe());
  print(result.isError); // true
  print(result.isValue); // false
  print(result.asValue?.value);

  final listResult = await Result.captureAll([getMe(), getMe(), 123]);
  print(listResult.map((e) => e.asValue?.value));
}

Future<String> getMe() async {
  Future.delayed(const Duration(seconds: 2));
  // throw 'no internet';

  return 'me';
}
