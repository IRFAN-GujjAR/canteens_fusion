import 'package:equatable/equatable.dart';

class ConvertLatLongToAddressParams extends Equatable {
  final String lat;
  final String long;

  const ConvertLatLongToAddressParams({required this.lat, required this.long});

  @override
  List<Object?> get props => [lat, long];
}
