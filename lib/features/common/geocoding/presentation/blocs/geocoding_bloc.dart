import 'dart:async';
import 'package:canteens_fusion/core/utils/initialize_app_utils.dart';
import 'package:canteens_fusion/features/common/geocoding/presentation/blocs/geocoding_events.dart';
import 'package:canteens_fusion/features/common/geocoding/presentation/blocs/geocoding_states.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/convert_lat_long_to_address_use_case.dart';
import 'exceptions/geocoding_exception.dart';

final class GeocodingBloc extends Bloc<GeocodingEvent, GeocodingState> {
  final ConvertLatLongToAddressUseCase _convertLatLongToAddressUseCase;

  GeocodingBloc(this._convertLatLongToAddressUseCase)
      : super(GeocodingStateInitial()) {
    on<GeocodingEventConvertLatLongToAddress>(
        (event, emit) async => await _onConvertLatLongToAddress(event, emit));
  }

  Future<void> _onConvertLatLongToAddress(
      GeocodingEventConvertLatLongToAddress event,
      Emitter<GeocodingState> emit) async {
    if (state is GeocodingStateLoaded) {
      emit(GeocodingStateReloading());
    } else {
      emit(GeocodingStateLoading());
    }
    try {
      final result = await _convertLatLongToAddressUseCase.call(event.params);
      emit(GeocodingStateLoaded(result));
    } on DioException catch (e) {
      customLogger.e(e);
      final msg = GeocodingException().errorMsg(e);
      emit(GeocodingStateError(msg));
    } catch (e) {
      customLogger.e(e);
      emit(GeocodingStateError(e.toString()));
    }
  }
}
