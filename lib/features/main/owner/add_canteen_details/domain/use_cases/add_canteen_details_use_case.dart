import 'package:canteens_fusion/core/core.dart';
import 'package:canteens_fusion/features/main/owner/add_canteen_details/domain/entities/canteen_details_entity.dart';
import 'package:canteens_fusion/features/main/owner/add_canteen_details/domain/repositories/add_canteen_details_repo.dart';
import 'package:canteens_fusion/features/main/owner/add_canteen_details/domain/use_cases/params/add_canteen_details_params.dart';

final class AddCanteenDetailsUseCase
    implements UseCase<CanteenDetailsEntity, AddCanteenDetailsParams> {
  final AddCanteenDetailsRepo _addCanteenDetailsRepo;

  AddCanteenDetailsUseCase(this._addCanteenDetailsRepo);

  @override
  Future<CanteenDetailsEntity> call(AddCanteenDetailsParams params) async {
    return await _addCanteenDetailsRepo.addCanteenDetails(params);
  }
}
