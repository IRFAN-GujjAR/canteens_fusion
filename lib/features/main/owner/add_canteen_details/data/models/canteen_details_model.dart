import 'package:canteens_fusion/features/main/owner/add_canteen_details/domain/entities/canteen_details_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'canteen_details_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CanteenDetailsModel extends Equatable {
  @JsonKey(name: 'canteen_name')
  final String canteenName;
  @JsonKey(name: 'canteen_photo_url')
  final String canteenPhotoUrl;
  @JsonKey(name: 'canteen_address')
  final CanteenAddressModel canteenAddress;

  const CanteenDetailsModel(
      {required this.canteenName,
      required this.canteenPhotoUrl,
      required this.canteenAddress});

  @override
  List<Object?> get props => [canteenName, canteenPhotoUrl, canteenAddress];

  CanteenDetailsEntity get toEntity => CanteenDetailsEntity(
      canteenName: canteenName,
      canteenPhotoUrl: canteenPhotoUrl,
      canteenAddress: CanteenAddressEntity(
        geocodingFormattedAddress: canteenAddress.geocodingFormattedAddress,
        geocodingPlaceId: canteenAddress.geocodingPlaceId,
        userEnteredAddress: canteenAddress.userEnteredAddress,
        city: canteenAddress.city,
        state: canteenAddress.state,
        currentLocation: LocationEntity(
            latitude: canteenAddress.currentLocation.latitude,
            longitude: canteenAddress.currentLocation.longitude),
        polygonPoints: canteenAddress.polygonPoints
            .map((e) =>
                LocationEntity(latitude: e.latitude, longitude: e.longitude))
            .toList(),
      ));

  CanteenDetailsModel updateCanteenPhotoUrl(String url) => CanteenDetailsModel(
      canteenName: canteenName,
      canteenPhotoUrl: url,
      canteenAddress: canteenAddress);

  factory CanteenDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$CanteenDetailsModelFromJson(json);
  Map<String, dynamic> toJson() => _$CanteenDetailsModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CanteenAddressModel extends Equatable {
  @JsonKey(name: 'geocoding_place_id')
  final String geocodingPlaceId;
  @JsonKey(name: 'geocoding_formatted_address')
  final String geocodingFormattedAddress;
  @JsonKey(name: 'user_entered_address')
  final String userEnteredAddress;
  final String city;
  final String state;
  @JsonKey(name: 'current_location')
  final LocationModel currentLocation;
  @JsonKey(name: 'polygon_points')
  final List<LocationModel> polygonPoints;

  const CanteenAddressModel(
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

  factory CanteenAddressModel.fromJson(Map<String, dynamic> json) =>
      _$CanteenAddressModelFromJson(json);
  Map<String, dynamic> toJson() => _$CanteenAddressModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LocationModel extends Equatable {
  final double latitude;
  final double longitude;

  const LocationModel({required this.latitude, required this.longitude});

  @override
  List<Object?> get props => [latitude, longitude];
  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);
  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}
