import 'package:canteens_fusion/core/constants/user_type_constants.dart';
import 'package:canteens_fusion/features/auth/data/models/user_model.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String email;
  final bool isEmailVerified;
  final UserType userType;
  final String phoneNumber;
  final String displayName;
  final String? photoUrl;

  const UserEntity({
    required this.uid,
    required this.email,
    required this.isEmailVerified,
    required this.userType,
    required this.phoneNumber,
    required this.displayName,
    this.photoUrl,
  });

  @override
  List<Object?> get props => [
        uid,
        email,
        isEmailVerified,
        userType,
        phoneNumber,
        displayName,
        photoUrl
      ];

  bool get isSignupCompleted =>
      phoneNumber.isNotEmpty && displayName.isNotEmpty;
  bool get isPhoneNumberVerified => phoneNumber.isNotEmpty;

  @override
  bool operator ==(Object other) =>
      other is UserEntity &&
      uid == other.uid &&
      email == other.email &&
      email == other.email &&
      isEmailVerified == other.isEmailVerified &&
      userType == other.userType &&
      phoneNumber == other.phoneNumber &&
      displayName == other.displayName &&
      photoUrl == other.photoUrl;

  UserModel get toUserModel {
    return UserModel(
        uid: uid,
        email: email,
        isEmailVerified: isEmailVerified,
        userType: userType,
        phoneNumber: phoneNumber,
        displayName: displayName);
  }
}
