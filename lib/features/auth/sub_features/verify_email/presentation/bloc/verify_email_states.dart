import 'package:canteens_fusion/features/auth/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

sealed class VerifyEmailState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class VerifyEmailInitialState extends VerifyEmailState {}

final class SendingEmailVerifyState extends VerifyEmailState {}

final class ReloadingUserEmailVerifyState extends VerifyEmailState {}

final class UserReloadedEmailVerifyState extends VerifyEmailState {}

final class EmailVerificationSentVerifyEmailState extends VerifyEmailState {
  final UserEntity user;

  EmailVerificationSentVerifyEmailState({required this.user});

  @override
  List<Object?> get props => [user];
}

final class EmailVerificationSuccessState extends VerifyEmailState {
  final UserEntity user;

  EmailVerificationSuccessState({required this.user});

  @override
  List<Object?> get props => [user];
}

final class VerifyEmailErrorState extends VerifyEmailState {
  final String errorMsg;

  VerifyEmailErrorState({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}
