import 'dart:async';

final locker = Locker();

void main() async {
  Future.wait([refreshToken(), refreshToken()]);
}

Future<void> refreshToken() async {
  await locker.lock(() async {
    await Future.delayed(const Duration(seconds: 2));
    print('Refresh token success');
  });
}

abstract class Lock {
  /// returns true if the lock is currently locked.
  bool get locked;

  /// The block running
  Future<dynamic>? waitLock();

  // Cleanup
  // waiting for the previous task to be done in case of timeout
  void unlock();

  /// Executes [computation] when lock is available.
  ///
  /// Only one asynchronous block can run while the lock is retained.
  Future<T> synchronized<T>(FutureOr<T> Function() computation);

  /// Executes [computation] when lock is available.
  ///
  /// Only one asynchronous block can run while the lock is retained.
  Future lock<T>(FutureOr<T> Function() computation, {Duration? timeout});
}

class Locker implements Lock {
  /// The last running block
  Future<dynamic>? _isWorking;
  Completer completer = Completer.sync();

  @override
  bool get locked => _isWorking != null;

  @override
  void unlock() {
    // Only mark it unlocked when the last one complete
    if (identical(_isWorking, completer.future)) {
      _isWorking = null;
    }
    completer.complete();
  }

  @override
  Future<dynamic>? waitLock() => _isWorking;

  @override
  Future lock<T>(FutureOr<T> Function() computation, {Duration? timeout}) async {
    if (locked) {
      await waitLock();
    } else {
      final prev = _isWorking;
      try {
        await synchronized(computation, timeout: timeout);
      } finally {
        // In case of timeout, wait for the previous one to complete too
        // before marking this task as complete
        if (prev != null && timeout != null) {
          // But we still returns immediately
          // ignore: unawaited_futures
          prev.then((_) {
            unlock();
          });
        } else {
          unlock();
        }
      }
    }
  }

  @override
  Future<T> synchronized<T>(FutureOr<T> Function() computation, {Duration? timeout}) async {
    final prev = _isWorking;
    completer = Completer.sync();
    _isWorking = completer.future;
    // Run the function and return the result
    // If there is a previous running block, wait for it
    if (prev != null) {
      if (timeout != null) {
        // This could throw a timeout error
        await prev.timeout(timeout);
      } else {
        await prev;
      }
    }
    final result = computation();
    if (result is Future) {
      if (timeout != null) {
        // This could throw a timeout error
        return await (result as Future).timeout(timeout);
      } else {
        return await result;
      }
    } else {
      return result;
    }
  }

  @override
  String toString() {
    return 'Lock[${identityHashCode(this)}]';
  }
}
