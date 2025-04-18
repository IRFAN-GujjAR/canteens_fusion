import 'package:canteens_fusion/features/common/geocoding/data/models/geocoding_latlong_to_address_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'geocoding_api_service.g.dart';

@RestApi(baseUrl: 'https://maps.googleapis.com/maps/api/geocode')
abstract class GeocodingApiService {
  factory GeocodingApiService(Dio dio) = _GeocodingApiService;

  @GET('/json')
  Future<GeocodingLatLongToAddressApiModel> convertLatLongToAddress({
    @Query('latlng') required String latLong,
    @Query('key') required String apiKey,
  });
}
