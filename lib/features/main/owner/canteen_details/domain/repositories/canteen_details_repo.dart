import 'package:canteens_fusion/features/main/owner/add_canteen_details/domain/entities/canteen_details_entity.dart';

abstract class CanteenDetailsRepo {
  Future<CanteenDetailsEntity> fetchCanteenDetails(String uid);
}
