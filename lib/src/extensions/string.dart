import 'package:samba_helpers/src/extensions/iterable.dart';

import '../enum/http_method.dart';

extension StringExtension on String {
  HttpMethod toHttpMethod() {
    final httpMethod = HttpMethod.values.firstWhereOrNull(
      (httpMethod) => httpMethod.name.toLowerCase() == toLowerCase(),
    );
    if (httpMethod == null) {
      throw StateError('No element');
    }
    return httpMethod;
  }
}
