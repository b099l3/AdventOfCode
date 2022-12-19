extension IterableExtension on Iterable<int> {
  int multiply() => reduce((a, b) => a * b);
  int add() => reduce((a, b) => a + b);
}
