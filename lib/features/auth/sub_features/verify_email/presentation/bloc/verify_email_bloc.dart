import 'dart:async';
import 'package:canteens_fusion/core/constants/user_type_constants.dart';
import 'package:canteens_fusion/core/utils/firebase/exceptions/custom_firebase_exceptions_utils.dart';
import 'package:canteens_fusion/core/utils/print_utils.dart';
import 'package:canteens_fusion/features/auth/domain/usecases/auth_reload_user_usecase.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/email_verified/params.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/email_verified/usecase.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_email/domain/usecases/send_verify_email_usecase.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_email/presentation/bloc/verify_email_events.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_email/presentation/bloc/verify_email_states.dart';
import 'package:canteens_fusion/features/auth/data/models/user_model.dart';
import 'package:canteens_fusion/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class VerifyEmailBloc extends Bloc<VerifyEmailEvent, VerifyEmailState> {
  final SendVerifyEmailUseCase _sendVerifyEmailUseCase;
  final AuthReloadUserUseCase _authReloadUserUseCase;
  final UserUpdateEmailVerifiedUseCase _userUpdateEmailVerifiedUseCase;
  late Timer _resendEmailTimer;

  VerifyEmailBloc(this._sendVerifyEmailUseCase, this._authReloadUserUseCase,
      this._userUpdateEmailVerifiedUseCase,
      {required UserType userType})
      : super(VerifyEmailInitialState()) {
    _resendEmailTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      add(ReloadUserConfirmVerifyEmailEvent(userType: userType));
    });
    on<SendEmailVerifyEmailEvent>((event, emit) async {
      await _onSendVerifyEmail(event.user, emit);
    });
    on<EmailConfirmedVerifyEmailEvent>((event, emit) {
      _onEmailVerified(event, emit);
    });
    on<ReloadUserConfirmVerifyEmailEvent>((event, emit) async {
      await _onReloadUser(event, emit);
    });
  }

  Future<void> _onSendVerifyEmail(
      UserEntity user, Emitter<VerifyEmailState> emit) async {
    emit(SendingEmailVerifyState());
    try {
      await _sendVerifyEmailUseCase.call;
      emit(EmailVerificationSentVerifyEmailState(user: user));
    } catch (e) {
      printDebugMesg(dartFileName: runtimeType.toString(), msg: e.toString());
      emit(VerifyEmailErrorState(
          errorMsg: FirebaseVerifyEmailExceptionsUtils().getErrorMsg(e)));
    }
  }

  void _onEmailVerified(
      EmailConfirmedVerifyEmailEvent event, Emitter<VerifyEmailState> emit) {
    final userModel = UserModel.fromFirebaseUser(
        firebaseUser: event.firebaseUser, userType: event.userType);
    emit(EmailVerificationSuccessState(user: userModel));
  }

  Future<void> _onReloadUser(ReloadUserConfirmVerifyEmailEvent event,
      Emitter<VerifyEmailState> emit) async {
    if (state is! ReloadingUserEmailVerifyState) {
      emit(ReloadingUserEmailVerifyState());
      try {
        final user = await _authReloadUserUseCase.call(event.userType);
        if (user.isEmailVerified) {
          await _userUpdateEmailVerifiedUseCase
              .call(UserUpdateEmailVerifiedParams(userType: user.userType));
          emit(EmailVerificationSuccessState(user: user));
        } else {
          emit(UserReloadedEmailVerifyState());
        }
      } on FirebaseException catch (e) {
        final errorMsg =
            FirebaseVerifyEmailExceptionsUtils().getErrorMsg(e.code);
        if (errorMsg == null) {
          emit(VerifyEmailErrorState(
              errorMsg: CustomFirebaseExceptionsUtils.unexpectedErrorMsg));
        } else {
          emit(VerifyEmailErrorState(errorMsg: errorMsg));
        }
        printDebugMesg(dartFileName: runtimeType.toString(), msg: e.toString());
      } catch (e) {
        printDebugMesg(dartFileName: runtimeType.toString(), msg: e.toString());
        emit(VerifyEmailErrorState(
            errorMsg: CustomFirebaseExceptionsUtils.unexpectedErrorMsg));
      }
    }
  }

  @override
  Future<void> close() {
    _resendEmailTimer.cancel();
    return super.close();
  }
}
