import 'package:async/async.dart';

void main() {
  // chạy 3 lần nhưng hàm _config chỉ chạy 1 lần
  AppConfig.getInstance().init();
  AppConfig.getInstance().init();
  AppConfig.getInstance().init();
}

class AppConfig {
  AppConfig._();

  factory AppConfig.getInstance() {
    return _instance;
  }

  static final AppConfig _instance = AppConfig._();

  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer<void>();

  Future<void> init() => _asyncMemoizer.runOnce(_config);

  Future<void> _config() async {
    print('run config');
  }
}
