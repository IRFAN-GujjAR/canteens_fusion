import 'package:canteens_fusion/core/providers/user_session_provider.dart';
import 'package:canteens_fusion/core/utils/dialogs/dialogs_utils.dart';
import 'package:canteens_fusion/core/utils/initialize_app_utils.dart';
import 'package:canteens_fusion/core/utils/maps/google_maps_polygon_utils.dart';
import 'package:canteens_fusion/core/utils/navigation/navigation_utils.dart';
import 'package:canteens_fusion/core/utils/navigation/owner/constants.dart';
import 'package:canteens_fusion/features/main/owner/add_canteen_details/domain/entities/canteen_details_entity.dart';
import 'package:canteens_fusion/features/main/owner/add_canteen_details/domain/use_cases/params/add_canteen_details_params.dart';
import 'package:canteens_fusion/features/main/owner/add_canteen_details/presentation/blocs/add_canteen_details_bloc.dart';
import 'package:canteens_fusion/features/main/owner/add_canteen_details/presentation/providers/add_canteen_address_provider.dart';
import 'package:canteens_fusion/features/main/owner/add_canteen_details/presentation/providers/add_canteen_details_provider.dart';
import 'package:canteens_fusion/features/main/owner/canteen_details/presentation/providers/canteen_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';

final class CanteenPolygonAreaProvider extends ChangeNotifier {
  final GoogleMapsPolygonUtils _polygonUtils = GoogleMapsPolygonUtils();
  GoogleMapsPolygonUtils get polygonUtils => _polygonUtils;
  bool _isMapLoading = true;
  bool get isMapLoading => _isMapLoading;
  set _setIsMapLoading(bool value) {
    _isMapLoading = value;
    notifyListeners();
  }

  Future<void> onMapCreated(BuildContext context,
      GoogleMapController mapController, Position currentLocation) async {
    try {
      await polygonUtils.onMapCreated(
          mapController: mapController,
          currentLocation: currentLocation,
          onDragEnd: () {
            notifyListeners();
          });
    } catch (e) {
      if (context.mounted) {
        DialogUtils.showMessageDialog(context,
            message:
                'An Error occurred while loading google maps. Please try again.');
      }
    }
    _setIsMapLoading = false;
  }

  void onFinishPressed(BuildContext context) async {
    if (polygonUtils.polygonPoints.isNotEmpty) {
      final uid = context.read<UserSessionProvider>().currentUser?.uid ?? '';
      final addCanteenDetailsProvider =
          context.read<AddCanteenDetailsProvider>();
      final String canteenName =
          addCanteenDetailsProvider.canteenNameTextController.text.trim();
      final canteenMainImageFile = addCanteenDetailsProvider.imageFile!;
      final addressDetails = addCanteenDetailsProvider.addressEntity!;

      final addCanteenAddressProvider =
          context.read<AddCanteenAddressProvider>();

      final currentLocation = LocationEntity(
          latitude: addCanteenAddressProvider.currentLocation.latitude,
          longitude: addCanteenAddressProvider.currentLocation.longitude);
      context.read<AddCanteenDetailsBloc>().add(AddCanteenDetailsEventAdd(
          AddCanteenDetailsParams(
              uid: uid,
              canteenMainImageFile: canteenMainImageFile,
              canteenDetails: CanteenDetailsEntity(
                  canteenName: canteenName,
                  canteenPhotoUrl: '',
                  canteenAddress: CanteenAddressEntity(
                      geocodingPlaceId: addressDetails.placeId,
                      geocodingFormattedAddress:
                          addressDetails.formattedAddress,
                      userEnteredAddress:
                          addCanteenAddressProvider.userEnteredAddress,
                      city: addCanteenAddressProvider.city,
                      state: addCanteenAddressProvider.state,
                      currentLocation: currentLocation,
                      polygonPoints: polygonUtils.polygonPoints
                          .map((e) => LocationEntity(
                              latitude: e.latitude, longitude: e.longitude))
                          .toList())))));
    } else {
      await DialogUtils.showMessageDialog(context, message: 'Map is loading');
    }
  }

  void handleAddCanteenDetailsBlocState(
      BuildContext context, AddCanteenDetailsState state) {
    switch (state) {
      case AddCanteenDetailsStateInitial():
      case AddCanteenDetailsStateAdding():
        customLogger.d(state);
        break;
      case AddCanteenDetailsStateAdded():
        final provider = context.read<CanteenDetailsProvider>();
        provider.setCanteenDetails = state.canteenDetails;
        provider.setState = CanteenDetailsProviderStates.loaded;
        NavigationUtils.navigate(
            context: context,
            removePreviousPages: true,
            ownerNavigationPageType: OwnerNavigationPageType.main);
        break;
      case AddCanteenDetailsStateError():
        DialogUtils.showErrorDialog(context, message: state.errorMsg);
        break;
    }
  }

  @override
  void dispose() {
    polygonUtils.mapController?.dispose();
    super.dispose();
  }
}
