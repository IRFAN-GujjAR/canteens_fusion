import 'package:canteens_fusion/features/main/owner/add_canteen_details/domain/use_cases/params/add_canteen_details_params.dart';

import '../entities/canteen_details_entity.dart';

abstract class AddCanteenDetailsRepo {
  Future<CanteenDetailsEntity> addCanteenDetails(
      AddCanteenDetailsParams params);
}
