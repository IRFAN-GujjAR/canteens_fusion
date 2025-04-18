import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class GeocodingLatLongToAddressEntity extends Equatable {
  final String placeId;
  final String formattedAddress;
  final String compoundPlusCode;
  final String globalPlusCode;
  final String city;
  final String state;

  const GeocodingLatLongToAddressEntity(
      {required this.placeId,
      required this.formattedAddress,
      required this.compoundPlusCode,
      required this.globalPlusCode,
      required this.city,
      required this.state});

  @override
  List<Object?> get props => [
        placeId,
        formattedAddress,
        compoundPlusCode,
        globalPlusCode,
        city,
        state
      ];
}
