import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

bool get isAndroid => Platform.isAndroid;

class CustomDeviceInfoUtils {
  static Future<AndroidDeviceInfo> get _androidDeviceInfo async {
    return await DeviceInfoPlugin().androidInfo;
  }

  static Future<int> get androidSdkVersion async {
    final info = await _androidDeviceInfo;
    return info.version.sdkInt;
  }
}
