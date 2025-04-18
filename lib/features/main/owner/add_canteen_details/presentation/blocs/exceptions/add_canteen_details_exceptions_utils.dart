import 'package:canteens_fusion/core/utils/firebase/exceptions/custom_firebase_exceptions_utils.dart';

final class AddCanteenDetailsExceptionsUtils
    extends CustomFirebaseExceptionsUtils {
  @override
  String getErrorMsg(dynamic e) {
    final errorMsg = super.getErrorMsg(e);
    if (errorMsg != null) {
      return errorMsg;
    } else {
      return CustomFirebaseExceptionsUtils.unexpectedErrorMsg;
    }
  }
}
