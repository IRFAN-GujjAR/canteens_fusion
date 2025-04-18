import 'package:flutter/foundation.dart';

void printDebugMesg({
  required String dartFileName,
  required String? msg,
}) {
  if (kDebugMode) print('$dartFileName: $msg');
}
