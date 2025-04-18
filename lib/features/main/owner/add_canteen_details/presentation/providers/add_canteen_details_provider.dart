import 'package:canteens_fusion/core/utils/bottom_sheets/bottom_sheet_utils.dart';
import 'package:canteens_fusion/core/utils/dialogs/dialogs_utils.dart';
import 'package:canteens_fusion/core/utils/initialize_app_utils.dart';
import 'package:canteens_fusion/core/utils/navigation/navigation_utils.dart';
import 'package:canteens_fusion/core/utils/navigation/owner/constants.dart';
import 'package:canteens_fusion/features/common/geocoding/domain/entities/geocoding_entity.dart';
import 'package:canteens_fusion/features/common/geocoding/domain/use_cases/params/convert_lat_long_to_address_params.dart';
import 'package:canteens_fusion/features/common/geocoding/presentation/blocs/geocoding_bloc.dart';
import 'package:canteens_fusion/features/common/geocoding/presentation/blocs/geocoding_events.dart';
import 'package:canteens_fusion/features/common/geocoding/presentation/blocs/geocoding_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../../../../../core/utils/permissions/custom_permission_handler_utils.dart';
import '../../../../../../core/utils/provider_utils.dart';
import 'add_canteen_address_provider.dart';

class AddCanteenDetailsProvider extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;
  final _canteenNameTextController = TextEditingController();
  TextEditingController get canteenNameTextController =>
      _canteenNameTextController;
  String get canteenName => canteenNameTextController.text.trim();

  XFile? _imageFile;
  XFile? get imageFile => _imageFile;
  set _setImageFile(XFile file) {
    _imageFile = file;
    notifyListeners();
  }

  bool _isCurrentLocationFetching = false;
  bool get isCurrentLocationFetching => _isCurrentLocationFetching;
  set _setIsCurrentLocationFetching(bool value) {
    _isCurrentLocationFetching = value;
    notifyListeners();
  }

  GeocodingLatLongToAddressEntity? _addressEntity;
  GeocodingLatLongToAddressEntity? get addressEntity => _addressEntity;

  Position? _position;
  Position? get position => _position;
  set _setPosition(Position position) {
    _position = position;
  }

  void pickImage(BuildContext context) {
    BottomSheetUtils.showPickImage(
      context,
      (file) async {
        _setImageFile = file;
      },
      cropStyle: CropStyle.rectangle,
      aspectRatio: const CropAspectRatio(ratioX: 1.5, ratioY: 1),
    );
  }

  void onNextPressed(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      if (imageFile != null) {
        _isCurrentLocationFetching = false;
        NavigationUtils.navigate(
          context: context,
          ownerNavigationPageType: OwnerNavigationPageType.addCanteenAddress,
        );
      } else {
        DialogUtils.showErrorDialog(
          context,
          message: 'Please add image of your canteen',
        );
      }
    }
  }

  void getAddressDetails(
    BuildContext context,
    GeocodingBloc geocodingBloc,
  ) async {
    try {
      if (await _requestPermission(context)) {
        _setIsCurrentLocationFetching = true;
        final position = await Geolocator.getCurrentPosition();
        _setPosition = position;
        geocodingBloc.add(
          GeocodingEventConvertLatLongToAddress(
            ConvertLatLongToAddressParams(
              lat: position.latitude.toString(),
              long: position.longitude.toString(),
            ),
          ),
        );
        customLogger.d(position.toJson());
        _setIsCurrentLocationFetching = false;
      }
    } catch (e) {
      _setIsCurrentLocationFetching = false;
      customLogger.e(e);
    }
  }

  void handleGeocodingBlocState(BuildContext context, GeocodingState state) {
    switch (state) {
      case GeocodingStateInitial():
      case GeocodingStateLoading():
      case GeocodingStateReloading():
        customLogger.d(state);
        break;
      case GeocodingStateLoaded():
        _addressEntity = state.geocodingLatLongToAddressEntity;
        final canteenAddressProvider =
            ProviderUtils<AddCanteenAddressProvider>().getProvider(
              context: context,
            );
        canteenAddressProvider.updateValues(
          entity: state.geocodingLatLongToAddressEntity,
          currentLocation: position!,
        );
        customLogger.d(state);
        break;
      case GeocodingStateError():
        DialogUtils.showMessageDialog(context, message: state.errorMsg);
        break;
    }
  }

  Future<bool> _requestPermission(BuildContext context) async {
    return await CustomPermissionHandlerUtils.requestLocation(context);
  }
}
