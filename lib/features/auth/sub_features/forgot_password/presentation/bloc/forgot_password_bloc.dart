import 'package:canteens_fusion/core/utils/firebase/exceptions/custom_firebase_exceptions_utils.dart';
import 'package:canteens_fusion/core/utils/print_utils.dart';
import 'package:canteens_fusion/features/auth/sub_features/forgot_password/domain/usecases/send_password_reset_email.dart';
import 'package:canteens_fusion/features/auth/sub_features/forgot_password/presentation/bloc/forgot_password_events.dart';
import 'package:canteens_fusion/features/auth/sub_features/forgot_password/presentation/bloc/forgot_password_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final SendPasswordResetEmailUseCase _sendPasswordResetEmailUseCase;

  ForgotPasswordBloc(this._sendPasswordResetEmailUseCase)
      : super(InitialForgotPasswordState()) {
    on<ForgotPasswordEvent>((event, emit) async {
      await _handleForgotPasswordEvent(event, emit);
    });
  }

  Future<void> _handleForgotPasswordEvent(
      ForgotPasswordEvent event, Emitter<ForgotPasswordState> emit) async {
    emit(SendingEmailForgotPasswordState());
    try {
      final forgotPasswordEntity =
          await _sendPasswordResetEmailUseCase.call(event.email);
      emit(EmailSentForgotPasswordState(email: forgotPasswordEntity.email));
    } on FirebaseAuthException catch (e) {
      final forgotPasswordException = ForgotPasswordExceptionsUtils();
      printDebugMesg(dartFileName: runtimeType.toString(), msg: e.toString());
      emit(ErrorForgotPasswordState(
          errorMsg: forgotPasswordException.getErrorMsg(e.code)));
    } catch (e) {
      printDebugMesg(dartFileName: runtimeType.toString(), msg: e.toString());
      emit(ErrorForgotPasswordState(
          errorMsg: CustomFirebaseExceptionsUtils.unexpectedErrorMsg));
    }
  }
}
