// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'canteen_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CanteenDetailsModel _$CanteenDetailsModelFromJson(Map json) => $checkedCreate(
      'CanteenDetailsModel',
      json,
      ($checkedConvert) {
        final val = CanteenDetailsModel(
          canteenName: $checkedConvert('canteen_name', (v) => v as String),
          canteenPhotoUrl:
              $checkedConvert('canteen_photo_url', (v) => v as String),
          canteenAddress: $checkedConvert(
              'canteen_address',
              (v) => CanteenAddressModel.fromJson(
                  Map<String, dynamic>.from(v as Map))),
        );
        return val;
      },
      fieldKeyMap: const {
        'canteenName': 'canteen_name',
        'canteenPhotoUrl': 'canteen_photo_url',
        'canteenAddress': 'canteen_address'
      },
    );

Map<String, dynamic> _$CanteenDetailsModelToJson(
        CanteenDetailsModel instance) =>
    <String, dynamic>{
      'canteen_name': instance.canteenName,
      'canteen_photo_url': instance.canteenPhotoUrl,
      'canteen_address': instance.canteenAddress.toJson(),
    };

CanteenAddressModel _$CanteenAddressModelFromJson(Map json) => $checkedCreate(
      'CanteenAddressModel',
      json,
      ($checkedConvert) {
        final val = CanteenAddressModel(
          geocodingPlaceId:
              $checkedConvert('geocoding_place_id', (v) => v as String),
          geocodingFormattedAddress: $checkedConvert(
              'geocoding_formatted_address', (v) => v as String),
          userEnteredAddress:
              $checkedConvert('user_entered_address', (v) => v as String),
          city: $checkedConvert('city', (v) => v as String),
          state: $checkedConvert('state', (v) => v as String),
          currentLocation: $checkedConvert(
              'current_location',
              (v) =>
                  LocationModel.fromJson(Map<String, dynamic>.from(v as Map))),
          polygonPoints: $checkedConvert(
              'polygon_points',
              (v) => (v as List<dynamic>)
                  .map((e) => LocationModel.fromJson(
                      Map<String, dynamic>.from(e as Map)))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'geocodingPlaceId': 'geocoding_place_id',
        'geocodingFormattedAddress': 'geocoding_formatted_address',
        'userEnteredAddress': 'user_entered_address',
        'currentLocation': 'current_location',
        'polygonPoints': 'polygon_points'
      },
    );

Map<String, dynamic> _$CanteenAddressModelToJson(
        CanteenAddressModel instance) =>
    <String, dynamic>{
      'geocoding_place_id': instance.geocodingPlaceId,
      'geocoding_formatted_address': instance.geocodingFormattedAddress,
      'user_entered_address': instance.userEnteredAddress,
      'city': instance.city,
      'state': instance.state,
      'current_location': instance.currentLocation.toJson(),
      'polygon_points': instance.polygonPoints.map((e) => e.toJson()).toList(),
    };

LocationModel _$LocationModelFromJson(Map json) => $checkedCreate(
      'LocationModel',
      json,
      ($checkedConvert) {
        final val = LocationModel(
          latitude: $checkedConvert('latitude', (v) => (v as num).toDouble()),
          longitude: $checkedConvert('longitude', (v) => (v as num).toDouble()),
        );
        return val;
      },
    );

Map<String, dynamic> _$LocationModelToJson(LocationModel instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
