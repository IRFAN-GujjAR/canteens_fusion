// ignore_for_file: hash_and_equals

import 'package:canteens_fusion/core/constants/user_type_constants.dart';
import 'package:canteens_fusion/core/utils/firebase/firebase_constants.dart';
import 'package:canteens_fusion/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

final class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.email,
    required super.isEmailVerified,
    required super.userType,
    required super.phoneNumber,
    required super.displayName,
    super.photoUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      FirebaseConstants.uid: uid,
      FirebaseConstants.email: email,
      FirebaseConstants.isEmailVerified: isEmailVerified,
      FirebaseConstants.userType: userTypes[userType]!,
      if (phoneNumber.isNotEmpty) FirebaseConstants.phoneNumber: phoneNumber,
      if (displayName.isNotEmpty) FirebaseConstants.displayName: displayName,
      if (photoUrl != null) FirebaseConstants.userPhotoUrl: photoUrl,
    };
  }

  Map<String, dynamic> toEmailVerifiedJson() {
    return {FirebaseConstants.isEmailVerified: isEmailVerified};
  }

  Map<String, dynamic> toPhoneNumberJson() {
    return {FirebaseConstants.phoneNumber: phoneNumber};
  }

  Map<String, dynamic> toDisplayNameJson() {
    return {FirebaseConstants.displayName: displayName};
  }

  Map<String, dynamic> toPhotoUrlJson() {
    return {FirebaseConstants.userPhotoUrl: photoUrl};
  }

  Map<String, dynamic> toDisplayNameAndUserPhotoUrlJson() {
    return {
      FirebaseConstants.displayName: displayName,
      FirebaseConstants.userPhotoUrl: photoUrl
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json[FirebaseConstants.uid],
      email: json[FirebaseConstants.email],
      userType: userTypesStoE[json[FirebaseConstants.userType]]!,
      isEmailVerified: json[FirebaseConstants.isEmailVerified],
      phoneNumber: json[FirebaseConstants.phoneNumber] ?? '',
      displayName: json[FirebaseConstants.displayName] ?? '',
      photoUrl: json[FirebaseConstants.userPhotoUrl],
    );
  }

  factory UserModel.fromFirebaseUser(
      {required User firebaseUser, required UserType userType}) {
    return UserModel(
        uid: firebaseUser.uid,
        email: firebaseUser.email!,
        isEmailVerified: firebaseUser.emailVerified,
        userType: userType,
        phoneNumber: firebaseUser.phoneNumber ?? '',
        displayName: firebaseUser.displayName ?? '',
        photoUrl: firebaseUser.photoURL);
  }

  @override
  bool operator ==(Object other) =>
      other is UserModel &&
      uid == other.uid &&
      email == other.email &&
      email == other.email &&
      isEmailVerified == other.isEmailVerified &&
      userType == other.userType &&
      phoneNumber == other.phoneNumber &&
      displayName == other.displayName &&
      photoUrl == other.photoUrl;
}

extension UserModelExtensions on UserModel {
  UserModel update(
      {UserType? userType,
      bool? isEmailVerified,
      String? displayName,
      String? photoUrl,
      String? phoneNumber}) {
    return UserModel(
        uid: uid,
        email: email,
        userType: userType ?? this.userType,
        isEmailVerified: isEmailVerified ?? this.isEmailVerified,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        displayName: displayName ?? this.displayName,
        photoUrl: photoUrl ?? this.photoUrl);
  }

  bool isUserUpdated(User user) {
    if (user.emailVerified != isEmailVerified) {
      return true;
    } else if (user.phoneNumber != null) {
      if (user.phoneNumber != phoneNumber) {
        return true;
      }
    } else if (user.displayName != null) {
      if (user.displayName != displayName) {
        return true;
      }
    } else if (user.photoURL != null) {
      if (user.photoURL != photoUrl) {
        return true;
      }
    }
    return false;
  }
}
