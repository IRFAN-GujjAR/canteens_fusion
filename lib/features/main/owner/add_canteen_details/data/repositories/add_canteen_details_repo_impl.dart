import 'package:canteens_fusion/core/utils/print_utils.dart';
import 'package:canteens_fusion/features/main/owner/add_canteen_details/data/data_sources/add_canteen_details_data_source.dart';
import 'package:canteens_fusion/features/main/owner/add_canteen_details/domain/entities/canteen_details_entity.dart';
import 'package:canteens_fusion/features/main/owner/add_canteen_details/domain/repositories/add_canteen_details_repo.dart';
import 'package:canteens_fusion/features/main/owner/add_canteen_details/domain/use_cases/params/add_canteen_details_params.dart';

final class AddCanteenDetailsRepoImpl implements AddCanteenDetailsRepo {
  final AddCanteenDetailsDataSource _dataSource;

  AddCanteenDetailsRepoImpl(this._dataSource);

  @override
  Future<CanteenDetailsEntity> addCanteenDetails(
      AddCanteenDetailsParams params) async {
    final result = await _dataSource.addCanteenDetails(
        params.uid, params.canteenMainImageFile, params.canteenDetails.toModel);
    return result.toEntity;
  }
}
