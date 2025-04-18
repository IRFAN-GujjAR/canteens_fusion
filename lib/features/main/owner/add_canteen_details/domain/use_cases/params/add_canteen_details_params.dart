import 'package:canteens_fusion/features/main/owner/add_canteen_details/domain/entities/canteen_details_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

final class AddCanteenDetailsParams extends Equatable {
  final String uid;
  final XFile canteenMainImageFile;
  final CanteenDetailsEntity canteenDetails;

  const AddCanteenDetailsParams(
      {required this.uid,
      required this.canteenMainImageFile,
      required this.canteenDetails});

  @override
  List<Object?> get props => [canteenMainImageFile, canteenDetails];
}
