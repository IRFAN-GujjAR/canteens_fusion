part of 'verify_phone_number_bloc.dart';

sealed class VerifyPhoneNumberState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class VerifyPhoneNumberInitial extends VerifyPhoneNumberState {}

final class SendingCodeToPhoneNumberState extends VerifyPhoneNumberState {}

final class CodeSentSuccessfullyState extends VerifyPhoneNumberState {}

final class VerificationCompletedPhoneNumberState
    extends VerifyPhoneNumberState {}

final class VerifyPhoneNumberErrorState extends VerifyPhoneNumberState {
  final String errorMsg;

  VerifyPhoneNumberErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];
}

final class OtpVerifyingPhoneNumberState extends VerifyPhoneNumberState {}

final class OtpVerificationSuccessPhoneNumberState
    extends VerifyPhoneNumberState {}

final class OtpVerificationErrorState extends VerifyPhoneNumberState {
  final String errorMsg;

  OtpVerificationErrorState({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}

final class PhoneNumberAlreadyInUseByOtherUserVerifyPhoneNumberState
    extends VerifyPhoneNumberState {
  final String phoneNumber;
  final String msg;

  PhoneNumberAlreadyInUseByOtherUserVerifyPhoneNumberState(
      {required this.phoneNumber, required this.msg});

  @override
  List<Object?> get props => [phoneNumber];
}

final class PhoneNumberAlreadyLinkedVerifyPhoneNumberState
    extends VerifyPhoneNumberState {}
