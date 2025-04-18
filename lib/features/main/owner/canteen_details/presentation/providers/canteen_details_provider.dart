import 'package:canteens_fusion/features/main/owner/add_canteen_details/domain/entities/canteen_details_entity.dart';
import 'package:canteens_fusion/features/main/owner/canteen_details/presentation/blocs/canteen_details_bloc.dart';
import 'package:flutter/material.dart';

final class CanteenDetailsProvider extends ChangeNotifier {
  CanteenDetailsEntity? _canteenDetails;
  CanteenDetailsEntity? get canteenDetails => _canteenDetails;

  set setCanteenDetails(CanteenDetailsEntity value) {
    _canteenDetails = value;
    notifyListeners();
  }

  CanteenDetailsProviderStates _state = CanteenDetailsProviderStates.initial;
  CanteenDetailsProviderStates get state => _state;
  set setState(CanteenDetailsProviderStates value) {
    _state = value;
    notifyListeners();
  }

  String _errorMsg = '';
  String get errorMsg => _errorMsg;
  set _setErrorMsg(String value) {
    _errorMsg = value;
  }

  void get _clearErrorMsg => _errorMsg = '';

  void handleCanteenDetailsBlocState(CanteenDetailsState state) {
    switch (state) {
      case CanteenDetailsStateInitial():
        _clearErrorMsg;
        setState = CanteenDetailsProviderStates.initial;
        break;
      case CanteenDetailsStateFetching():
        _clearErrorMsg;
        setState = CanteenDetailsProviderStates.fetching;
        break;
      case CanteenDetailsStateLoaded():
        _clearErrorMsg;
        _canteenDetails = state.canteenDetails;
        setState = CanteenDetailsProviderStates.loaded;
        break;
      case CanteenDetailsStateError():
        _setErrorMsg = state.errorMsg;
        setState = CanteenDetailsProviderStates.error;
        break;
      case CanteenDetailsStateNoCanteenFound():
        _clearErrorMsg;
        setState = CanteenDetailsProviderStates.canteenNotFound;
        break;
    }
  }
}

enum CanteenDetailsProviderStates {
  initial,
  fetching,
  loaded,
  canteenNotFound,
  error
}
