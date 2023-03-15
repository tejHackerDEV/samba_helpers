import 'package:samba_helpers/src/extensions/iterable.dart';

extension MapExtensions on Map<String, dynamic> {
  /// This function will add a new [key] along with the provided [value]
  /// in the provided [map], if no value present for that [key] in the [map].
  ///
  /// If a value is already present for that [key] in the provided [map],
  /// then its [value] will be converted to a [List] consisting both previousValue
  /// as well as the currentValue.
  ///
  /// If the already present value is an [List] then it will be spread into the
  /// newly constructed [List], thus maintain the [value] type as [List<dynamic>],
  /// instead of [List<List<dynamic>>]
  void addOrUpdateValue<T>({
    required final String key,
    required final dynamic value,
  }) {
    final valueThatAlreadyExists = this[key];
    // value doesn't exists so simply insert the value as MultipartFormData
    if (valueThatAlreadyExists == null) {
      this[key] = value;
    } else {
      // value already exists so convert as list & append the old & new value
      // into it.
      if (valueThatAlreadyExists is Iterable) {
        // If the value that already exists is Iterable then spread it
        // into new list. But before doing so just check whether the value
        // we are dealing with is already an Iterable or not with the specified type.
        //
        // If we failed to do so then the value will be spread-ed which we don't
        // want to happen.
        if (valueThatAlreadyExists is! Iterable<T>) {
          this[key] = [...valueThatAlreadyExists, value];
          return;
        }
      }
      this[key] = [valueThatAlreadyExists, value];
    }
  }

  /// Checks [Map]s [a] and [b] for equality.
  ///
  /// Returns `true` if [a] and [b] are both null, or they are the same length
  /// and every key `k` in [a] exists in [b] and the values `a[k] == b[k]`.
  bool equalsTo(Map<String, dynamic> other) {
    if (this == other) {
      return true;
    }
    if (length != other.length) {
      return false;
    }

    for (final k in keys) {
      final aValue = this[k];
      final bValue = other[k];

      if (aValue is Iterable) {
        if (bValue is! Iterable) {
          return false;
        }
        if (!aValue.equalsTo(bValue)) {
          return false;
        }
      } else if (aValue is Map<String, dynamic>) {
        if (bValue is! Map<String, dynamic>) {
          return false;
        }
        if (!aValue.equalsTo(bValue)) {
          return false;
        }
      } else if (aValue != bValue) {
        return false;
      }
    }

    return true;
  }
}
