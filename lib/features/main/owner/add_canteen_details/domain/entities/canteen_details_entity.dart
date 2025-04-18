import 'package:canteens_fusion/features/main/owner/add_canteen_details/data/models/canteen_details_model.dart';
import 'package:equatable/equatable.dart';

class CanteenDetailsEntity extends Equatable {
  final String canteenName;
  final String canteenPhotoUrl;
  final CanteenAddressEntity canteenAddress;

  const CanteenDetailsEntity(
      {required this.canteenName,
      required this.canteenPhotoUrl,
      required this.canteenAddress});

  @override
  List<Object?> get props => [canteenName, canteenPhotoUrl, canteenAddress];

  CanteenDetailsModel get toModel => CanteenDetailsModel(
      canteenName: canteenName,
      canteenPhotoUrl: canteenPhotoUrl,
      canteenAddress: CanteenAddressModel(
        geocodingFormattedAddress: canteenAddress.geocodingFormattedAddress,
        geocodingPlaceId: canteenAddress.geocodingPlaceId,
        userEnteredAddress: canteenAddress.userEnteredAddress,
        city: canteenAddress.city,
        state: canteenAddress.state,
        currentLocation: LocationModel(
            latitude: canteenAddress.currentLocation.latitude,
            longitude: canteenAddress.currentLocation.longitude),
        polygonPoints: canteenAddress.polygonPoints
            .map((e) =>
                LocationModel(latitude: e.latitude, longitude: e.longitude))
            .toList(),
      ));
}

class CanteenAddressEntity extends Equatable {
  final String geocodingPlaceId;
  final String geocodingFormattedAddress;
  final String userEnteredAddress;
  final String city;
  final String state;
  final LocationEntity currentLocation;
  final List<LocationEntity> polygonPoints;

  const CanteenAddressEntity(
      {required this.geocodingPlaceId,
      required this.geocodingFormattedAddress,
      required this.userEnteredAddress,
      required this.city,
      required this.state,
      required this.currentLocation,
      required this.polygonPoints});

  @override
  List<Object?> get props => [
        geocodingPlaceId,
        geocodingFormattedAddress,
        userEnteredAddress,
        city,
        state,
        currentLocation,
        polygonPoints
      ];
}

class LocationEntity extends Equatable {
  final double latitude;
  final double longitude;

  const LocationEntity({required this.latitude, required this.longitude});

  @override
  List<Object?> get props => [latitude, longitude];
}
