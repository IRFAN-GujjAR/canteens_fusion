import 'package:canteens_fusion/core/core.dart';
import 'package:canteens_fusion/features/common/geocoding/domain/entities/geocoding_entity.dart';
import 'package:canteens_fusion/features/common/geocoding/domain/repositories/geocoding_repo.dart';
import 'package:canteens_fusion/features/common/geocoding/domain/use_cases/params/convert_lat_long_to_address_params.dart';

final class ConvertLatLongToAddressUseCase
    implements
        UseCase<GeocodingLatLongToAddressEntity,
            ConvertLatLongToAddressParams> {
  final GeocodingRepo _geocodingRepo;

  ConvertLatLongToAddressUseCase(this._geocodingRepo);

  @override
  Future<GeocodingLatLongToAddressEntity> call(
      ConvertLatLongToAddressParams params) async {
    return _geocodingRepo.convertLatLongToAddress(params: params);
  }
}
