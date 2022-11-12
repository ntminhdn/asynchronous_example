import 'dart:async';

void main() {
  print('Start');

  // Step 1: 1
  Future(() => 1).then(print);

  // Step 2: 1 -> Future(() => 2)
  Future(() => Future(() => 2)).then(print);

  // Step 3: 3 -> 1 -> Future(() => 2)
  Future.microtask(() => 3).then(print);

  // Step 4: 3 -> 1 -> Future(() => 4) -> Future(() => 2)
  Future.microtask(() => Future(() => 4)).then(print);

  // Step 5: 3 -> 1 -> 5 -> Future(() => 4) -> Future(() => 2)
  Future(() => 5).then(print);

  // Step 6: 3 -> 1 -> 5 -> Future(() => 4) -> Future(() => 2) -> Future(() => 6)
  // Output là: 3 -> 1 -> 5 -> 4 -> 2 -> 6
  Future(() => Future(() => 6)).then(print);

  print('End');
}
