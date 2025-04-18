part of 'verify_phone_number_bloc.dart';

sealed class VerifyPhoneNumberEvent extends Equatable {
  const VerifyPhoneNumberEvent();

  @override
  List<Object?> get props => [];
}

final class StartVerificationVerifyPhoneNumberEvent
    extends VerifyPhoneNumberEvent {
  final String phoneNumber;

  const StartVerificationVerifyPhoneNumberEvent({required this.phoneNumber});
  @override
  List<Object?> get props => [phoneNumber];
}

final class OnVerificationCompletedEvent extends VerifyPhoneNumberEvent {}

final class OnVerificationFailedEvent extends VerifyPhoneNumberEvent {
  final String errorMsg;

  const OnVerificationFailedEvent({required this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];
}

final class OnCodeSentEvent extends VerifyPhoneNumberEvent {}

final class VerifyOtpPhoneNumberEvent extends VerifyPhoneNumberEvent {
  final VerifyPhoneNumberVerifyOtpParams verifyOtpParams;
  final UserUpdatePhoneNumberParams updatePhoneNumberParams;

  const VerifyOtpPhoneNumberEvent(
      {required this.verifyOtpParams, required this.updatePhoneNumberParams});

  @override
  List<Object?> get props => [verifyOtpParams, updatePhoneNumberParams];
}
