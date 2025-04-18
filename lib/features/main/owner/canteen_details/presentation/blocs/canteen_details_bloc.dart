import 'package:canteens_fusion/features/main/owner/add_canteen_details/domain/entities/canteen_details_entity.dart';
import 'package:canteens_fusion/features/main/owner/canteen_details/presentation/blocs/exceptions/canteen_details_exceptions_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/canteen_details_use_case_fetch.dart';

part 'canteen_details_event.dart';
part 'canteen_details_state.dart';

class CanteenDetailsBloc
    extends Bloc<CanteenDetailsEvent, CanteenDetailsState> {
  final CanteenDetailsUseCaseFetch _canteenDetailsUseCaseFetch;

  CanteenDetailsBloc(this._canteenDetailsUseCaseFetch)
      : super(CanteenDetailsStateInitial()) {
    on<CanteenDetailsEventFetch>((event, emit) async {
      await _fetchCanteenDetails(event, emit);
    });
  }

  Future<void> _fetchCanteenDetails(
      CanteenDetailsEventFetch event, Emitter<CanteenDetailsState> emit) async {
    emit(CanteenDetailsStateFetching());
    try {
      final canteenDetails = await _canteenDetailsUseCaseFetch.call(event.uid);
      emit(CanteenDetailsStateLoaded(canteenDetails));
    } on CanteenDetailsNoCanteenFoundException {
      emit(CanteenDetailsStateNoCanteenFound());
    } catch (e) {
      emit(CanteenDetailsStateError(
          CanteenDetailsExceptionsUtils().getErrorMsg(e)));
    }
  }
}
