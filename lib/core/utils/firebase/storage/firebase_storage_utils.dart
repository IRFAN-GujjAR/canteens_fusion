import 'dart:io';

import 'package:canteens_fusion/core/constants/user_type_constants.dart';
import 'package:canteens_fusion/core/utils/initialize_app_utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class FirebaseStorageUtils {
  static const _requestTimeOutSeconds = Duration(seconds: 8);

  static const _customers = 'customers';
  static const _owners = 'owners';
  static const _profileImage = 'profile_image';

  static FirebaseStorage get firebaseStorage => locator.get<FirebaseStorage>();

  static Reference profileImageRef(
      {required FirebaseStorage storage,
      required UserType userType,
      required String uid,
      required String fileName}) {
    return storage
        .ref(userType.isCustomer ? _customers : _owners)
        .child(uid)
        .child(_profileImage)
        .child(fileName);
  }

  static Reference canteenMainImageRef(
      {required FirebaseStorage storage,
      required String uid,
      required String fileName}) {
    return storage
        .ref(_owners)
        .child(uid)
        .child('canteen')
        .child('main_image')
        .child(fileName);
  }

  static Future<String> uploadFile(
      {required FirebaseStorage storage,
      required Reference ref,
      required XFile file}) async {
    final result =
        await ref.putFile(File(file.path)).timeout(_requestTimeOutSeconds);
    return result.ref.getDownloadURL().timeout(_requestTimeOutSeconds);
  }
}
