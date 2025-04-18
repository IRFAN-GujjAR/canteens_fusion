import 'package:canteens_fusion/core/constants/user_type_constants.dart';
import 'package:canteens_fusion/core/utils/file_utils.dart';
import 'package:canteens_fusion/core/utils/firebase/auth/firebase_auth_utils.dart';
import 'package:canteens_fusion/core/utils/firebase/cloud_firestore/cloud_firestore_utils.dart';
import 'package:canteens_fusion/core/utils/firebase/storage/firebase_storage_utils.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/display_name_and_photo_url/params.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/display_name/params.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/email/params.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/email_verified/params.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/phone_number/params.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/photo_url/params.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

abstract class UserUpdateDataSource {
  Future<void> updateDisplayName(UserUpdateDisplayNameParams params);
  Future<void> updateEmail(UserUpdateEmailParams params);
  Future<void> updateEmailVerified(UserUpdateEmailVerifiedParams params);
  Future<void> updatePhoneNumber(UserUpdatePhoneNumberParams params);
  Future<void> updatePhoto(UserUpdatePhotoParams params);
  Future<void> updateDisplayNameAndPhoto(
      UserUpdateDisplayNameAndPhotoParams params);
}

class UserUpdateDataSourceImpl implements UserUpdateDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _fireStore;
  final FirebaseStorage _storage;

  UserUpdateDataSourceImpl(this._firebaseAuth, this._fireStore, this._storage);

  @override
  Future<void> updateDisplayName(UserUpdateDisplayNameParams params) async {
    if (params.updateFirebaseAuth) {
      await FirebaseAuthUtils.updateDisplayName(_currentUser,
          displayName: params.name);
    }
    if (params.updateFireStore) {
      await _updateFireStoreUser(
          userType: params.userType, uid: _uid, updatedFields: params.toJson());
    }
  }

  @override
  Future<void> updateEmailVerified(UserUpdateEmailVerifiedParams params) async {
    await _updateFireStoreUser(
        userType: params.userType, uid: _uid, updatedFields: params.toJson());
  }

  @override
  Future<void> updateEmail(UserUpdateEmailParams params) async {
    if (params.updateFirebaseAuth) {
      await FirebaseAuthUtils.updateEmail(_currentUser, email: params.email);
    }
    if (params.updateFireStore) {
      await _updateFireStoreUser(
          userType: params.userType, uid: _uid, updatedFields: params.toJson());
    }
  }

  @override
  Future<void> updatePhoneNumber(UserUpdatePhoneNumberParams params) async {
    if (params.updateFirebaseAuth) {
      if (params.phoneAuthCredential == null) {
        throw 'Phone Auth Credential is null';
      }
      await FirebaseAuthUtils.updatePhoneNumber(_currentUser,
          phoneAuthCredential: params.phoneAuthCredential!);
    }
    if (params.updateFireStore) {
      await _updateFireStoreUser(
          userType: params.userType, uid: _uid, updatedFields: params.toJson());
    }
  }

  @override
  Future<void> updatePhoto(UserUpdatePhotoParams params) async {
    final profileImageUrl = await _updateProfileImageInStorage(
        params.profileImage, params.userType);
    if (params.updateFireStore) {
      await _updateFireStoreUser(
          userType: params.userType,
          uid: _uid,
          updatedFields: params.toJson(profileImageUrl));
    }
    if (params.updateFirebaseAuth) {
      await FirebaseAuthUtils.updatePhotoUrl(_currentUser,
          photoUrl: profileImageUrl);
    }
  }

  @override
  Future<void> updateDisplayNameAndPhoto(
      UserUpdateDisplayNameAndPhotoParams params) async {
    final profileImage = params.profileImage;
    var profileImageUrl = '';
    if (profileImage != null) {
      profileImageUrl =
          await _updateProfileImageInStorage(profileImage, params.userType);
    }
    if (params.updateFireStore) {
      await _updateFireStoreUser(
          userType: params.userType,
          uid: _uid,
          updatedFields: params.toJson(profileImageUrl));
    }
    if (params.updateFirebaseAuth) {
      await FirebaseAuthUtils.updateDisplayName(_currentUser,
          displayName: params.name);
      await FirebaseAuthUtils.updatePhotoUrl(_currentUser,
          photoUrl: profileImageUrl);
    }
  }

  Future<void> _updateFireStoreUser(
      {required UserType userType,
      required String uid,
      required Map<String, dynamic> updatedFields}) async {
    final docRef = CloudFireStoreUtils.getUserReference(_fireStore,
        userType: userType, uid: uid);
    await CloudFireStoreUtils.updateDocument(docRef, data: updatedFields);
  }

  Future<String> _updateProfileImageInStorage(
      XFile profileImage, UserType userType) async {
    final ref = FirebaseStorageUtils.profileImageRef(
        storage: _storage,
        userType: userType,
        uid: _uid,
        fileName:
            FileUtils.getFileName(file: profileImage, fileName: 'profile'));
    return await FirebaseStorageUtils.uploadFile(
        storage: _storage, ref: ref, file: profileImage);
  }

  User get _currentUser => _firebaseAuth.currentUser!;
  String get _uid => _currentUser.uid;
}
