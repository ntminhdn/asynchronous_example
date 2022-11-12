import 'package:async/async.dart';

// Nó giống như một [Completer] mà có thể cancel được Future. Hoặc có thể hiểu nó giống như một [CancelableOperation] mà có thêm chức năng [complete()] như [Completer].
// Tương tự [CancelableOperation]. Nếu Future đã chạy thì Future đó vẫn sẽ chạy cho đến hết nhưng nó sẽ ko trigger hàm [cancelableCompleter.operation.value.whenComplete] và [cancelableCompleter.operation.value.then]
void main() {
  vd2();
}

/// Cancel lúc Future chưa chạy thì ta có thể check để Future ko thể chạy
void vd1() {
  CancelableCompleter cancelableCompleter = CancelableCompleter(onCancel: () {
    print('Canceled!');
  });

  // Cancel lúc Future chưa chạy
  cancelableCompleter.operation.cancel();

  // check trước khi cho Future chạy
  if (!cancelableCompleter.isCanceled) {
    cancelableCompleter.complete(Future(() async {
      await Future<dynamic>.delayed(const Duration(milliseconds: 2000));
      // Câu này được print ra, chứng tỏ Future vẫn chạy dù đã cancel
      print('2 3 con mực, anh thích giống đực');

      // Câu này ko được print ra, chứng tỏ hàm value.then và value.whenComplete ko được trigger khi đã cancel
      return '2 3 con nhái, anh thích con gái';
    }));
  }

  // kiểm tra xem Future được chạy hay ko?
  print('isCanceled: ${cancelableCompleter.isCanceled}');
  print('isCompleted: ${cancelableCompleter.isCompleted}');
  cancelableCompleter.operation.value.then((value) => {
        print('then: $value'),
      });
  cancelableCompleter.operation.value.whenComplete(() => {
        print('Completed!'),
      });
}

/// Cancel lúc Future đã chạy thì Future sẽ tiếp tục chạy đến hết
void vd2() {
  CancelableCompleter cancelableCompleter = CancelableCompleter(onCancel: () {
    print('Canceled!');
  });

  // check trước khi cho Future chạy
  if (!cancelableCompleter.isCanceled) {
    cancelableCompleter.complete(Future(() async {
      await Future<dynamic>.delayed(const Duration(milliseconds: 2000));
      // Câu này được print ra, chứng tỏ Future vẫn chạy dù đã cancel
      print('2 3 con mực, anh thích giống đực');

      // Câu này ko được print ra, chứng tỏ hàm value.then và value.whenComplete ko được trigger khi đã cancel
      return '2 3 con nhái, anh thích con gái';
    }));
  }

  // Cancel lúc Future đã chạy thì Future vẫn tiếp tục chạy
  cancelableCompleter.operation.cancel();

  // kiểm tra xem Future được chạy hay ko?
  print('isCanceled: ${cancelableCompleter.isCanceled}');
  print('isCompleted: ${cancelableCompleter.isCompleted}');
  cancelableCompleter.operation.value.then((value) => {
        print('then: $value'),
      });
  cancelableCompleter.operation.value.whenComplete(() => {
        print('Completed!'),
      });
}
