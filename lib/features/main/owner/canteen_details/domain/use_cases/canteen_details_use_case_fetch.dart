import 'package:canteens_fusion/core/core.dart';
import 'package:canteens_fusion/features/main/owner/add_canteen_details/domain/entities/canteen_details_entity.dart';
import 'package:canteens_fusion/features/main/owner/canteen_details/domain/repositories/canteen_details_repo.dart';

final class CanteenDetailsUseCaseFetch
    implements UseCase<CanteenDetailsEntity, String> {
  final CanteenDetailsRepo _canteenDetailsRepo;

  CanteenDetailsUseCaseFetch(this._canteenDetailsRepo);

  @override
  Future<CanteenDetailsEntity> call(String uid) async {
    return await _canteenDetailsRepo.fetchCanteenDetails(uid);
  }
}
