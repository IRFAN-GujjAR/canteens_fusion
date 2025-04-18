import 'package:canteens_fusion/core/constants/user_type_constants.dart';
import 'package:canteens_fusion/features/auth/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

sealed class VerifyEmailEvent extends Equatable {}

final class SendEmailVerifyEmailEvent extends VerifyEmailEvent {
  final UserEntity user;

  SendEmailVerifyEmailEvent({required this.user});

  @override
  List<Object?> get props => [user];
}

final class EmailConfirmedVerifyEmailEvent extends VerifyEmailEvent {
  final User firebaseUser;
  final UserType userType;

  EmailConfirmedVerifyEmailEvent(
      {required this.firebaseUser, required this.userType});
  @override
  List<Object?> get props => [firebaseUser, userType];
}

final class ReloadUserConfirmVerifyEmailEvent extends VerifyEmailEvent {
  final UserType userType;

  ReloadUserConfirmVerifyEmailEvent({required this.userType});
  @override
  List<Object?> get props => [userType];
}
