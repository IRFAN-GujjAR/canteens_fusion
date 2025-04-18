import 'package:canteens_fusion/core/constants/user_type_constants.dart';
import 'package:canteens_fusion/core/utils/firebase/exceptions/custom_firebase_exceptions_utils.dart';
import 'package:canteens_fusion/core/utils/print_utils.dart';
import 'package:canteens_fusion/features/auth/sub_features/sign_up/domain/usecases/register_user_use_case.dart';
import 'package:canteens_fusion/features/auth/sub_features/sign_up/presentation/bloc/signup_events.dart';
import 'package:canteens_fusion/features/auth/sub_features/sign_up/presentation/bloc/signup_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupRegisterUserUseCase _registerUserUseCase;

  SignupBloc(this._registerUserUseCase) : super(SignupInitialState()) {
    on<RegisterUserEvent>((event, emit) async {
      emit(RegisteringState());
      try {
        final user = await _registerUserUseCase.call(event.params);
        if (user.userType.isCustomer) {
          printDebugMesg(
              msg: 'Customer Registered', dartFileName: runtimeType.toString());
          emit(UserSignupSuccessState(user: user));
        } else {
          printDebugMesg(
              msg: 'Owner Registered', dartFileName: runtimeType.toString());
          emit(UserSignupSuccessState(user: user));
        }
      } catch (e) {
        printDebugMesg(dartFileName: runtimeType.toString(), msg: e.toString());
        emit(SignupErrorState(
            errorMsg: SignupFirebaseExceptionsUtils().getErrorMsg(e)));
      }
    });
  }
}
