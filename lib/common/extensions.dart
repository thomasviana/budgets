extension Flatten on Iterable<bool> {
  bool flatten() => fold(
        true,
        (a, b) => a && b,
      );
}
