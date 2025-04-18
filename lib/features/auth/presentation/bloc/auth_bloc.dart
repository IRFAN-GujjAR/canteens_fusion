import 'package:canteens_fusion/core/utils/firebase/exceptions/custom_firebase_exceptions_utils.dart';
import 'package:canteens_fusion/core/utils/print_utils.dart';
import 'package:canteens_fusion/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:canteens_fusion/features/auth/domain/entities/user_entity.dart';
import 'package:canteens_fusion/features/auth/domain/usecases/params/login_params.dart';
import 'package:canteens_fusion/features/auth/domain/usecases/auth_login_usecase.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_events.dart';
part 'auth_states.dart';

final class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthLoginUseCase _authLoginUseCase;

  AuthBloc(AuthRepoImpl authRepoImpl)
      : _authLoginUseCase = AuthLoginUseCase(authRepoImpl),
        super(AuthInitialState()) {
    on<AuthLoginEvent>((event, emit) async {
      await _onLoginEvent(event, emit);
    });
  }

  Future<void> _onLoginEvent(
      AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoggingInState());
    try {
      final userModel = await _authLoginUseCase.call(event.loginParams);
      emit(UserLoggedInState(user: userModel));
    } on AuthWrongUserTypeErrorState catch (e) {
      printDebugMesg(dartFileName: runtimeType.toString(), msg: e.errorMsg);
      emit(e);
    } on AuthLoginErrorState catch (e) {
      printDebugMesg(dartFileName: runtimeType.toString(), msg: e.errorMsg);
      emit(e);
    } catch (e) {
      printDebugMesg(dartFileName: runtimeType.toString(), msg: e.toString());
      emit(AuthLoginErrorState(
          errorMsg: LoginFirebaseExceptionsUtils().getErrorMsg(e)));
    }
  }
}
