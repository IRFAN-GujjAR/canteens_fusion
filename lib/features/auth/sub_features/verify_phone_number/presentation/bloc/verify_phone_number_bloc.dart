import 'dart:async';
import 'package:canteens_fusion/core/utils/firebase/exceptions/custom_firebase_exceptions_utils.dart';
import 'package:canteens_fusion/core/utils/initialize_app_utils.dart';
import 'package:canteens_fusion/core/utils/print_utils.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/phone_number/params.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/phone_number/usecase.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_phone_number/domain/usecases/params/send_otp_params.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_phone_number/domain/usecases/params/verify_otp_params.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_phone_number/domain/usecases/send_otp_use_case.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_phone_number/domain/usecases/verify_otp_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'verify_phone_number_event.dart';
part 'verify_phone_number_state.dart';

final class VerifyPhoneNumberBloc
    extends Bloc<VerifyPhoneNumberEvent, VerifyPhoneNumberState> {
  late final VerifyPhoneNumberSendOtpUseCase _sendOtpUseCase;
  late final VerifyPhoneNumberVerifyOtpUseCase _verifyOtpUseCase;
  late final UserUpdatePhoneNumberUseCase _phoneNumberUseCase;

  StreamSubscription? _streamSubscription;
  final _verificationController =
      StreamController<StartVerificationVerifyPhoneNumberEvent>();

  VerifyPhoneNumberBloc(
      this._sendOtpUseCase, this._verifyOtpUseCase, this._phoneNumberUseCase)
      : super(VerifyPhoneNumberInitial()) {
    _streamSubscription = _verificationController.stream.listen((event) async {
      try {
        await _sendOtpUseCase.call(VerifyPhoneNumberSendOtpParams(
            phoneNumber: event.phoneNumber,
            onVerificationCompleted: () {
              add(OnVerificationCompletedEvent());
            },
            onVerificationFailed: (e) {
              add(OnVerificationFailedEvent(
                  errorMsg: FirebaseVerifyPhoneNumberExceptionsUtils()
                      .getErrorMsg(e)));
            },
            onCodeSent: () {
              locator.get<FirebaseAuth>().currentUser!.reload().then((value) {
                printDebugMesg(
                    dartFileName: 'dartFileName',
                    msg: locator.get<FirebaseAuth>().currentUser.toString());
                add(OnCodeSentEvent());
              });
            }));
      } catch (error) {
        add(OnVerificationFailedEvent(errorMsg: error.toString()));
      }
    });
    on<StartVerificationVerifyPhoneNumberEvent>((event, emit) async {
      emit(SendingCodeToPhoneNumberState());
      _verificationController.add(event);
    });
    on<OnVerificationCompletedEvent>(
        (event, emit) => emit(VerificationCompletedPhoneNumberState()));
    on<OnVerificationFailedEvent>((event, emit) =>
        emit(VerifyPhoneNumberErrorState(errorMsg: event.errorMsg)));
    on<OnCodeSentEvent>((event, emit) => emit(CodeSentSuccessfullyState()));
    on<VerifyOtpPhoneNumberEvent>((event, emit) async {
      try {
        emit(OtpVerifyingPhoneNumberState());
        await _verifyOtpUseCase.call(event.verifyOtpParams);
        await _phoneNumberUseCase.call(event.updatePhoneNumberParams);
        emit(OtpVerificationSuccessPhoneNumberState());
      } catch (e) {
        customLogger.e('Fuck Error : $e');
        final linkWithCredentialException = LinkWithCredentialExceptionsUtils();
        final type = linkWithCredentialException.getExceptionType(e);
        if (type == CustomFirebaseExceptionType.providerAlreadyLinked) {
          emit(PhoneNumberAlreadyLinkedVerifyPhoneNumberState());
        } else if (type == CustomFirebaseExceptionType.crednetialAlreadyInUse) {
          emit(PhoneNumberAlreadyInUseByOtherUserVerifyPhoneNumberState(
              phoneNumber: event.updatePhoneNumberParams.phoneNumber,
              msg: linkWithCredentialException.getErrorMsg(e)));
        } else {
          emit(OtpVerificationErrorState(
              errorMsg: linkWithCredentialException.getErrorMsg(e)));
        }
      }
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
