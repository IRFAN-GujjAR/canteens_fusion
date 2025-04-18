import 'package:canteens_fusion/features/common/geocoding/data/api/geocoding_api_service.dart';
import 'package:canteens_fusion/features/common/geocoding/domain/use_cases/params/convert_lat_long_to_address_params.dart';
import 'package:dio/dio.dart';

import '../../../../../core/utils/initialize_app_utils.dart';
import '../models/geocoding_latlong_to_address_model.dart';

abstract class GeocodingDataSource {
  Future<GeocodingLatLongToAddressModel> convertLatLongToAddress(
    ConvertLatLongToAddressParams params,
  );
}

class GeocodingDataSourceImpl implements GeocodingDataSource {
  final GeocodingApiService _geocodingApiService = GeocodingApiService(
    Dio(
      BaseOptions(
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    ),
  );

  @override
  Future<GeocodingLatLongToAddressModel> convertLatLongToAddress(
    ConvertLatLongToAddressParams params,
  ) async {
    final lat = params.lat;
    final long = params.long;
    final response = await _geocodingApiService.convertLatLongToAddress(
      latLong: '$lat,$long',
      apiKey: geoCodingApiKey,
    );
    if (response.status == 'OK' && response.results.isNotEmpty) {
      final result = response.results[0];
      final formattedAddress = result.formattedAddress;
      final addressComponents = result.addressComponents;

      String city = '';
      String state = '';

      for (final component in addressComponents) {
        final types = component.types;
        if (types.contains('locality')) {
          city = component.longName;
        } else if (types.contains('administrative_area_level_1')) {
          state = component.shortName;
        }
      }
      return GeocodingLatLongToAddressModel(
        placeId: result.placeId,
        formattedAddress: formattedAddress,
        compoundPlusCode: response.plusCode.compoundCode,
        globalPlusCode: response.plusCode.globalCode,
        city: city,
        state: state,
      );
    } else {
      throw ('No Address found with your current location');
    }
  }
}
