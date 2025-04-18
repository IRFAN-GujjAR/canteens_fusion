import 'package:canteens_fusion/features/common/geocoding/data/data_sources/geocoding_data_source.dart';
import 'package:canteens_fusion/features/common/geocoding/data/models/geocoding_latlong_to_address_model.dart';
import 'package:canteens_fusion/features/common/geocoding/domain/repositories/geocoding_repo.dart';
import 'package:canteens_fusion/features/common/geocoding/domain/use_cases/params/convert_lat_long_to_address_params.dart';

final class GeocodingRepoImpl implements GeocodingRepo {
  final GeocodingDataSource _geocodingDataSource;

  GeocodingRepoImpl(this._geocodingDataSource);

  @override
  Future<GeocodingLatLongToAddressModel> convertLatLongToAddress(
      {required ConvertLatLongToAddressParams params}) async {
    return await _geocodingDataSource.convertLatLongToAddress(params);
  }
}
