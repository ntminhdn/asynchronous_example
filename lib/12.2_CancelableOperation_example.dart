import 'package:async/async.dart';

void main() {
  // Ko thể cancel 1 Future đã chạy. Nó sẽ chạy đến hết.
  // Nó chỉ đơn giản là ko trigger hàm [cancelableOperation.value.whenComplete]
  // Khi sử dụng CancelToken của dio để cancel API ta sẽ thấy mặc dù đã cancel nhưng API vẫn được gọi và có thể trả về 200. Tuy nhiên, chúng ta có thể dựa vào hàm [cancelableOperation.value.whenComplete] để từ chối lấy response từ các API đã bị cancel hoặc check trạng thái [cancelableOperation.isCanceled] trước khi gọi API để tránh lãng phí.
  final cancelableOperation = CancelableOperation<int>.fromFuture(Future(
    () async {
      await Future.delayed(const Duration(seconds: 3)); // thử đổi thành 1s hoặc 3s
      print('Đã cancel nhưng kết quả vẫn được in ra');

      return 100;
    },
  ));

  Future.delayed(const Duration(seconds: 2), () async {
    cancelableOperation.cancel();
    print(
        'isCanceled: ${cancelableOperation.isCanceled}, isCompleted: ${cancelableOperation.isCompleted}');

    // nếu đã bị cancel thì trả về -1, ngược lại trả về 100
    final value = await cancelableOperation.valueOrCancellation(-1);
    print(value);
  });

  // nếu đã bị cancel thì hàm này ko thể trigger
  cancelableOperation.value.whenComplete(() => print('Done!'));
}
