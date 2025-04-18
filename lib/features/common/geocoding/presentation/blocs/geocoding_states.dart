import 'package:canteens_fusion/features/common/geocoding/domain/entities/geocoding_entity.dart';
import 'package:equatable/equatable.dart';

sealed class GeocodingState extends Equatable {}

final class GeocodingStateInitial extends GeocodingState {
  @override
  List<Object?> get props => [];
}

final class GeocodingStateLoading extends GeocodingState {
  @override
  List<Object?> get props => [];
}

final class GeocodingStateReloading extends GeocodingState {
  @override
  List<Object?> get props => [];
}

final class GeocodingStateLoaded extends GeocodingState {
  final GeocodingLatLongToAddressEntity geocodingLatLongToAddressEntity;

  GeocodingStateLoaded(this.geocodingLatLongToAddressEntity);

  @override
  List<Object?> get props => [geocodingLatLongToAddressEntity];
}

final class GeocodingStateError extends GeocodingState {
  final String errorMsg;

  GeocodingStateError(this.errorMsg);

  @override
  List<Object?> get props => [errorMsg];
}
