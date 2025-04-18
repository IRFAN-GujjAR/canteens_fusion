// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geocoding_latlong_to_address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeocodingLatLongToAddressApiModel _$GeocodingLatLongToAddressApiModelFromJson(
        Map json) =>
    $checkedCreate(
      'GeocodingLatLongToAddressApiModel',
      json,
      ($checkedConvert) {
        final val = GeocodingLatLongToAddressApiModel(
          plusCode: $checkedConvert('plus_code',
              (v) => PlusCode.fromJson(Map<String, dynamic>.from(v as Map))),
          results: $checkedConvert(
              'results',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      Result.fromJson(Map<String, dynamic>.from(e as Map)))
                  .toList()),
          status: $checkedConvert('status', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'plusCode': 'plus_code'},
    );

PlusCode _$PlusCodeFromJson(Map json) => $checkedCreate(
      'PlusCode',
      json,
      ($checkedConvert) {
        final val = PlusCode(
          compoundCode: $checkedConvert('compound_code', (v) => v as String),
          globalCode: $checkedConvert('global_code', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'compoundCode': 'compound_code',
        'globalCode': 'global_code'
      },
    );

Result _$ResultFromJson(Map json) => $checkedCreate(
      'Result',
      json,
      ($checkedConvert) {
        final val = Result(
          addressComponents: $checkedConvert(
              'address_components',
              (v) => (v as List<dynamic>)
                  .map((e) => AddressComponent.fromJson(
                      Map<String, dynamic>.from(e as Map)))
                  .toList()),
          formattedAddress:
              $checkedConvert('formatted_address', (v) => v as String),
          placeId: $checkedConvert('place_id', (v) => v as String),
          types: $checkedConvert('types',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'addressComponents': 'address_components',
        'formattedAddress': 'formatted_address',
        'placeId': 'place_id'
      },
    );

AddressComponent _$AddressComponentFromJson(Map json) => $checkedCreate(
      'AddressComponent',
      json,
      ($checkedConvert) {
        final val = AddressComponent(
          longName: $checkedConvert('long_name', (v) => v as String),
          shortName: $checkedConvert('short_name', (v) => v as String),
          types: $checkedConvert('types',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
        );
        return val;
      },
      fieldKeyMap: const {'longName': 'long_name', 'shortName': 'short_name'},
    );
