import 'package:samba_helpers/src/extensions/iterable.dart';

import '../enum/http_method.dart';

extension StringExtension on String {
  HttpMethod toHttpMethod() {
    return HttpMethod.values.firstWhereOrNull(
            (httpMethod) => httpMethod.name.toLowerCase() == toLowerCase()) ??
        HttpMethod.get;
  }
}
