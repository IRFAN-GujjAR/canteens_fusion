import 'package:canteens_fusion/features/common/geocoding/domain/use_cases/params/convert_lat_long_to_address_params.dart';
import 'package:equatable/equatable.dart';

sealed class GeocodingEvent extends Equatable {}

final class GeocodingEventConvertLatLongToAddress extends GeocodingEvent {
  final ConvertLatLongToAddressParams params;

  GeocodingEventConvertLatLongToAddress(this.params);

  @override
  List<Object?> get props => [params];
}
