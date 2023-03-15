extension IterableExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test, {T? Function()? orElse}) {
    for (T element in this) {
      if (test(element)) return element;
    }
    if (orElse != null) return orElse();
    return null;
  }

  bool listsEqual(List? a, List? b) {
    if (a == b) return true;
    if (a == null || b == null) return false;
    if (a.length != b.length) return false;

    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }

    return true;
  }

  /// Checks the currentList on which we calling this function
  /// with the [other] list for equality.
  ///
  /// Returns `true` if [this] and [other] were null, or
  /// they were having the same length and every element `i`
  /// exists in both [this] & [other] along with there values equal
  /// `this.elementAt(i) == other.elementAt(i)`.
  bool equalsTo(Iterable<T>? other) {
    if (this == null || other == null) {
      return true;
    }
    if (this!.length != other.length) {
      return false;
    }

    for (int i = 0; i < this!.length; ++i) {
      final element = this!.elementAt(i);
      final otherElement = other.elementAt(i);
      // if the element we want to check is an iterable
      // then recursively call this function & check for equality
      if (element is Iterable) {
        if (otherElement is! Iterable) {
          return false;
        }
        if (!element.equalsTo(otherElement)) {
          return false;
        }
      } else if (element != otherElement) {
        // not an iterable so check for normal comparision
        return false;
      }
    }

    return true;
  }
}
