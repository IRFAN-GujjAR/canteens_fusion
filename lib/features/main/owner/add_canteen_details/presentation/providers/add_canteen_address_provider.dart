import 'package:canteens_fusion/core/utils/navigation/navigation_utils.dart';
import 'package:canteens_fusion/core/utils/navigation/owner/constants.dart';
import 'package:canteens_fusion/core/utils/permissions/custom_permission_handler_utils.dart';
import 'package:canteens_fusion/features/common/geocoding/domain/entities/geocoding_entity.dart';
import 'package:canteens_fusion/features/common/geocoding/presentation/blocs/geocoding_states.dart';
import 'package:canteens_fusion/features/main/owner/add_canteen_details/presentation/pages/canteen_address/canteen_polygon_area/canteen_polygon_area_page.dart';
import 'package:canteens_fusion/features/main/owner/add_canteen_details/presentation/providers/add_canteen_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/utils/initialize_app_utils.dart';
import '../../../../../common/geocoding/domain/use_cases/params/convert_lat_long_to_address_params.dart';
import '../../../../../common/geocoding/presentation/blocs/geocoding_bloc.dart';
import '../../../../../common/geocoding/presentation/blocs/geocoding_events.dart';

final class AddCanteenAddressProvider extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final _addressTxtController = TextEditingController();
  TextEditingController get canteenAddressTxtController =>
      _addressTxtController;
  String get userEnteredAddress => canteenAddressTxtController.text.trim();

  final _cityTxtController = TextEditingController();
  TextEditingController get cityTxtController => _cityTxtController;
  String get city => cityTxtController.text.trim();

  final _stateTxtController = TextEditingController();
  TextEditingController get stateTxtController => _stateTxtController;
  String get state => stateTxtController.text.trim();

  bool _isAddressDetailsReFetching = false;
  bool get isAddressDetailsReFetching => _isAddressDetailsReFetching;
  set _setIsAddressDetailsReFetching(bool value) {
    _isAddressDetailsReFetching = value;
    notifyListeners();
  }

  late Position _currentLocation;
  Position get currentLocation => _currentLocation;
  set _setCurrentLocation(Position value) => _currentLocation = value;

  // AddCanteenAddressProvider(
  //     GeocodingLatLongToAddressEntity entity, Position position) {
  //   _setCurrentLocation = position;
  //   _updateTxtControllers(entity);
  // }

  void updateValues(
      {required GeocodingLatLongToAddressEntity entity,
      required Position currentLocation}) {
    _setCurrentLocation = currentLocation;
    _updateTxtControllers(entity);
  }

  void _updateTxtControllers(GeocodingLatLongToAddressEntity entity) {
    final address = entity.formattedAddress.split(',');
    address.removeWhere((element) =>
        element.contains(entity.city) ||
        element.contains(entity.state) ||
        element.contains('Pakistan'));
    final formattedAddress = address.join(',');
    _addressTxtController.text = formattedAddress;
    _cityTxtController.text = entity.city;
    _stateTxtController.text = entity.state;
  }

  void onNextPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      NavigationUtils.navigate(
          context: context,
          ownerNavigationPageType:
              OwnerNavigationPageType.canteenPolygonAreaPage);
    }
  }

  void reFetchAddressDetails(
      BuildContext context, GeocodingBloc geocodingBloc) async {
    try {
      if (await CustomPermissionHandlerUtils.requestLocation(context)) {
        _setIsAddressDetailsReFetching = true;
        final position = await Geolocator.getCurrentPosition();
        _setCurrentLocation = position;
        geocodingBloc.add(GeocodingEventConvertLatLongToAddress(
            ConvertLatLongToAddressParams(
                lat: position.latitude.toString(),
                long: position.longitude.toString())));
        customLogger.d(position.toJson());
        _setIsAddressDetailsReFetching = false;
      }
    } catch (e) {
      _setIsAddressDetailsReFetching = false;
      customLogger.e(e);
    }
  }

  void handleGeocodingBlocState(GeocodingState state) {
    if (state is GeocodingStateLoaded) {
      _updateTxtControllers(state.geocodingLatLongToAddressEntity);
    }
  }

  @override
  void dispose() {
    _stateTxtController.dispose();
    _cityTxtController.dispose();
    _addressTxtController.dispose();
    super.dispose();
  }
}
