import 'package:canteens_fusion/core/utils/firebase/exceptions/custom_firebase_exceptions_utils.dart';
import 'package:canteens_fusion/core/utils/print_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/complete_customer_profile_use_case.dart';
import 'complete_profile_events.dart';
import 'complete_profile_states.dart';

class CompleteProfileBloc
    extends Bloc<CompleteProfileEvent, CompleteProfileState> {
  final CompleteCustomerProfileUseCase _completeCustomerProfileUseCase;

  CompleteProfileBloc(this._completeCustomerProfileUseCase)
      : super(CompleteProfileInitialState()) {
    on<CompleteProfileEvent>((event, emit) async {
      await _handleEvent(event, emit);
    });
  }

  Future<void> _handleEvent(
      CompleteProfileEvent event, Emitter<CompleteProfileState> emit) async {
    emit(CompleteProfileLoadingState());
    try {
      final user = await _completeCustomerProfileUseCase.call(event.params);
      emit(CompleteProfileLoadedState(user));
    } on FirebaseException catch (e) {
      printDebugMesg(dartFileName: runtimeType.toString(), msg: e.toString());

      final errorMsg =
          CompleteCustomerProfileExceptionsUtils().getErrorMsg(e.code);
      emit(CompleteProfileErrorState(errorMsg));
    } catch (e) {
      printDebugMesg(dartFileName: runtimeType.toString(), msg: e.toString());

      emit(CompleteProfileErrorState(
          CustomFirebaseExceptionsUtils.unexpectedErrorMsg));
    }
  }
}
