import 'package:canteens_fusion/core/providers/user_session_provider.dart';
import 'package:canteens_fusion/core/utils/firebase/cloud_firestore/cloud_firestore_utils.dart';
import 'package:canteens_fusion/core/utils/firebase/storage/firebase_storage_utils.dart';
import 'package:canteens_fusion/core/utils/navigation/owner/constants.dart';
import 'package:canteens_fusion/features/common/geocoding/data/data_sources/geocoding_data_source.dart';
import 'package:canteens_fusion/features/common/geocoding/data/repositories/geocoding_repo_impl.dart';
import 'package:canteens_fusion/features/common/geocoding/domain/use_cases/convert_lat_long_to_address_use_case.dart';
import 'package:canteens_fusion/features/common/geocoding/presentation/blocs/geocoding_bloc.dart';
import 'package:canteens_fusion/features/main/owner/add_canteen_details/data/data_sources/add_canteen_details_data_source.dart';
import 'package:canteens_fusion/features/main/owner/add_canteen_details/data/repositories/add_canteen_details_repo_impl.dart';
import 'package:canteens_fusion/features/main/owner/add_canteen_details/domain/use_cases/add_canteen_details_use_case.dart';
import 'package:canteens_fusion/features/main/owner/add_canteen_details/presentation/blocs/add_canteen_details_bloc.dart';
import 'package:canteens_fusion/features/main/owner/add_canteen_details/presentation/pages/add_canteen_details_page.dart';
import 'package:canteens_fusion/features/main/owner/add_canteen_details/presentation/pages/canteen_address/add_canteen_address_page.dart';
import 'package:canteens_fusion/features/main/owner/add_canteen_details/presentation/pages/canteen_address/canteen_polygon_area/canteen_polygon_area_page.dart';
import 'package:canteens_fusion/features/main/owner/add_canteen_details/presentation/providers/add_canteen_address_provider.dart';
import 'package:canteens_fusion/features/main/owner/add_canteen_details/presentation/providers/add_canteen_details_provider.dart';
import 'package:canteens_fusion/features/main/owner/add_canteen_details/presentation/providers/canteen_polygon_area_provider.dart';
import 'package:canteens_fusion/features/main/owner/canteen_details/presentation/blocs/canteen_details_bloc.dart';
import 'package:canteens_fusion/features/main/owner/canteen_details/presentation/pages/check_canteen_details_page/check_canteen_details_page.dart';
import 'package:canteens_fusion/features/main/owner/main/owner_main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

part '../pages/owner/add_canteen_address_page.dart';
part '../pages/owner/add_canteen_details_page.dart';
part '../pages/owner/canteen_polygon_area_page.dart';
part '../pages/owner/check_canteen_details_page.dart';

final class OwnerNavigationUtils {
  static Widget getNavigationPage(
    BuildContext context, {
    required OwnerNavigationPageType navigationPageType,
    bool usePreviousDependencies = false,
  }) {
    switch (navigationPageType) {
      case OwnerNavigationPageType.checkCanteenDetails:
        return _checkCanteenDetailsPage(context);
      case OwnerNavigationPageType.addCanteenDetails:
        return _addCanteenDetailsPage;
      case OwnerNavigationPageType.addCanteenAddress:
        return _addCanteenAddressPage(context);
      case OwnerNavigationPageType.canteenPolygonAreaPage:
        return _canteenPolygonAreaPage(context);
      case OwnerNavigationPageType.main:
        return const OwnerMainPage();
    }
  }
}
