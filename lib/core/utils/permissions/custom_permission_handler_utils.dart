import 'package:canteens_fusion/core/utils/dialogs/dialogs_utils.dart';
import 'package:canteens_fusion/core/utils/print_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

import '../device_info/custom_device_info_utils.dart';

final class CustomPermissionHandlerUtils {
  static Future<bool> requestCamera(BuildContext context) async {
    try {
      return await _handlePermission(context, Permission.camera, 'camera');
    } catch (e) {
      printDebugMesg(
          dartFileName: 'CustomPermissionHandlerUtils : Permission Error',
          msg: e.toString());
    }
    return false;
  }

  static Future<bool> requestGallery(BuildContext context) async {
    try {
      var permission = Permission.photos;
      if (isAndroid) {
        if (await CustomDeviceInfoUtils.androidSdkVersion <= 32) {
          permission = Permission.storage;
        }
      }
      if (context.mounted) {
        return await _handlePermission(context, permission, 'gallery');
      }
    } catch (e) {
      printDebugMesg(
          dartFileName: 'CustomPermissionHandlerUtils : Permission Error',
          msg: e.toString());
    }
    return false;
  }

  static Future<bool> requestLocation(BuildContext context) async {
    if (await _requestLocationServices(context)) {
      if (context.mounted) {
        return await _requestAppLocation(context);
      }
    }
    return false;
  }

  static Future<bool> _requestLocationServices(BuildContext context) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (context.mounted) {
        await DialogUtils.showMessageDialog(context,
            message:
                'Location services are disabled. Please enable the services');
      }
    }
    return serviceEnabled;
  }

  static Future<bool> _requestAppLocation(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      if (context.mounted) {
        final value = await DialogUtils.showAlertDialog(context,
            message:
                'You need to enable location services in your app settings');
        if (value) {
          await Geolocator.openAppSettings();
        }
      }
    } else if (permission == LocationPermission.denied) {
      if (context.mounted) {
        final value = await DialogUtils.showAlertDialog(context,
            message: 'You need to allow location permission to proceed further',
            proceedButtonTxt: 'Retry');
        if (value) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.deniedForever) {
            if (context.mounted) {
              final value = await DialogUtils.showAlertDialog(context,
                  message:
                      'You need to enable location services in your app settings');
              if (value) {
                await Geolocator.openAppSettings();
              }
            }
          } else {
            if (context.mounted) {
              return await _requestAppLocation(context);
            }
          }
        }
      }
    } else {
      return true;
    }
    return false;
  }

  static Future<PermissionStatus> _permissionStatus(
      Permission permission) async {
    return await permission.status;
  }

  static Future<bool> _handlePermission(BuildContext context,
      Permission permission, String permissionName) async {
    final status = await _permissionStatus(permission);
    if (status.isPermanentlyDenied) {
      if (context.mounted) {
        final value = await DialogUtils.showAlertDialog(context,
            message: 'Allow $permissionName permission in settings');
        if (value) {
          await openAppSettings();
        }
      }
    } else if (status.isGranted) {
      return true;
    } else if (status.isLimited && permission == Permission.photos) {
      return true;
    } else if (status.isDenied) {
      final newStatus = await permission.request();
      if (newStatus.isGranted) {
        return true;
      }
    }
    return false;
  }
}
