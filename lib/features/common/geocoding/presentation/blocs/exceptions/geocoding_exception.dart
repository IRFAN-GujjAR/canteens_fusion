import 'package:dio/dio.dart';

import '../../../../../../core/utils/custom_dio_exceptions/custom_http_exceptions_utils.dart';

final class GeocodingException extends CustomHttpExceptionsUtils {
  @override
  String errorMsg(DioException e) {
    final msg = super.errorMsg(e);
    if (msg == null) {
      return e.toString();
    }
    return msg;
  }
}
