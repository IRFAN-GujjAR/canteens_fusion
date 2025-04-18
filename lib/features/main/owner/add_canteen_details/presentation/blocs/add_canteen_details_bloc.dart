import 'dart:async';
import 'package:canteens_fusion/features/main/owner/add_canteen_details/domain/entities/canteen_details_entity.dart';
import 'package:canteens_fusion/features/main/owner/add_canteen_details/domain/use_cases/params/add_canteen_details_params.dart';
import 'package:canteens_fusion/features/main/owner/add_canteen_details/presentation/blocs/exceptions/add_canteen_details_exceptions_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/add_canteen_details_use_case.dart';

part 'add_canteen_details_event.dart';
part 'add_canteen_details_state.dart';

class AddCanteenDetailsBloc
    extends Bloc<AddCanteenDetailsEvent, AddCanteenDetailsState> {
  final AddCanteenDetailsUseCase _addCanteenDetailsUseCase;

  AddCanteenDetailsBloc(this._addCanteenDetailsUseCase)
      : super(AddCanteenDetailsStateInitial()) {
    on<AddCanteenDetailsEventAdd>((event, emit) async {
      await _onAddCanteenDetails(event, emit);
    });
  }

  Future<void> _onAddCanteenDetails(AddCanteenDetailsEventAdd event,
      Emitter<AddCanteenDetailsState> emit) async {
    emit(AddCanteenDetailsStateAdding());
    try {
      final canteenDetails = await _addCanteenDetailsUseCase.call(event.params);
      emit(AddCanteenDetailsStateAdded(canteenDetails));
    } catch (e) {
      emit(AddCanteenDetailsStateError(
          AddCanteenDetailsExceptionsUtils().getErrorMsg(e)));
    }
  }
}
