import 'package:canteens_fusion/features/main/owner/add_canteen_details/domain/entities/canteen_details_entity.dart';
import 'package:canteens_fusion/features/main/owner/canteen_details/data/data_sources/canteen_details_data_source.dart';
import 'package:canteens_fusion/features/main/owner/canteen_details/domain/repositories/canteen_details_repo.dart';

final class CanteenDetailsRepoImpl implements CanteenDetailsRepo {
  final CanteenDetailsDataSource _canteenDetailsDataSource;

  CanteenDetailsRepoImpl(this._canteenDetailsDataSource);

  @override
  Future<CanteenDetailsEntity> fetchCanteenDetails(String uid) async {
    final canteenDetails =
        await _canteenDetailsDataSource.fetchCanteenDetails(uid);
    return canteenDetails.toEntity;
  }
}
