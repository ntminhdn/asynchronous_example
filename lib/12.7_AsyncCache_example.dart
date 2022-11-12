import 'package:async/async.dart';

void main() async {
  final u1 = await me;
  print(u1);

  await Future.delayed(const Duration(seconds: 3));
  // currentUserCache.invalidate(); // xoá cache
  final u2 = await me;
  print(u2);

  await Future.delayed(const Duration(seconds: 3));
  final u3 = await me;
  print(u3);
}

final currentUserCache = AsyncCache<String>(const Duration(seconds: 5));

/// Uses the cache if it exists, otherwise calls the closure:
Future<String> get me => currentUserCache.fetch(() async {
      return await _getMe();
    });

Future<String> _getMe() async {
  return DateTime.now().toIso8601String();
}
