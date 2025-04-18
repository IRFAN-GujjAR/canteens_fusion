import 'package:canteens_fusion/core/utils/firebase/exceptions/custom_firebase_exceptions_utils.dart';

final class CanteenDetailsExceptionsUtils
    extends CustomFirebaseExceptionsUtils {
  @override
  String getErrorMsg(dynamic e) {
    final msg = super.getErrorMsg(e);
    if (msg == null) {
      return CustomFirebaseExceptionsUtils.unexpectedErrorMsg;
    }
    return msg;
  }
}

final class CanteenDetailsNoCanteenFoundException {}
