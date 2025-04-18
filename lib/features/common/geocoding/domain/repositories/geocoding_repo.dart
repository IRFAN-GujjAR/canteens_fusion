import 'package:canteens_fusion/features/common/geocoding/domain/use_cases/params/convert_lat_long_to_address_params.dart';

import '../entities/geocoding_entity.dart';

abstract class GeocodingRepo {
  Future<GeocodingLatLongToAddressEntity> convertLatLongToAddress(
      {required ConvertLatLongToAddressParams params});
}
