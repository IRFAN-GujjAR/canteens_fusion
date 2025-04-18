import 'package:canteens_fusion/core/utils/initialize_app_utils.dart';
import 'package:canteens_fusion/features/common/geocoding/domain/entities/geocoding_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'geocoding_latlong_to_address_model.g.dart';

class GeocodingLatLongToAddressModel extends GeocodingLatLongToAddressEntity {
  const GeocodingLatLongToAddressModel(
      {required super.placeId,
      required super.formattedAddress,
      required super.compoundPlusCode,
      required super.globalPlusCode,
      required super.city,
      required super.state});
}

@JsonSerializable(createToJson: false)
class GeocodingLatLongToAddressApiModel {
  @JsonKey(name: 'plus_code')
  PlusCode plusCode;
  List<Result> results;
  String status;

  GeocodingLatLongToAddressApiModel({
    required this.plusCode,
    required this.results,
    required this.status,
  });

  factory GeocodingLatLongToAddressApiModel.fromJson(
      Map<String, dynamic> json) {
    customLogger.d('Json $json');
    return _$GeocodingLatLongToAddressApiModelFromJson(json);
  }
}

@JsonSerializable(createToJson: false)
class PlusCode {
  @JsonKey(name: 'compound_code')
  String compoundCode;
  @JsonKey(name: 'global_code')
  String globalCode;

  PlusCode({
    required this.compoundCode,
    required this.globalCode,
  });

  factory PlusCode.fromJson(Map<String, dynamic> json) =>
      _$PlusCodeFromJson(json);
}

@JsonSerializable(createToJson: false)
class Result {
  @JsonKey(name: 'address_components')
  List<AddressComponent> addressComponents;
  @JsonKey(name: 'formatted_address')
  String formattedAddress;
  @JsonKey(name: 'place_id')
  String placeId;
  List<String> types;

  Result({
    required this.addressComponents,
    required this.formattedAddress,
    required this.placeId,
    required this.types,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
}

@JsonSerializable(createToJson: false)
class AddressComponent {
  @JsonKey(name: 'long_name')
  String longName;
  @JsonKey(name: 'short_name')
  String shortName;
  List<String> types;

  AddressComponent({
    required this.longName,
    required this.shortName,
    required this.types,
  });

  factory AddressComponent.fromJson(Map<String, dynamic> json) =>
      _$AddressComponentFromJson(json);
}
