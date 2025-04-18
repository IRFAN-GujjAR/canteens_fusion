import 'package:canteens_fusion/core/utils/firebase/cloud_firestore/cloud_firestore_utils.dart';
import 'package:canteens_fusion/features/main/owner/add_canteen_details/data/models/canteen_details_model.dart';
import 'package:canteens_fusion/features/main/owner/canteen_details/presentation/blocs/exceptions/canteen_details_exceptions_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../add_canteen_details/domain/entities/canteen_details_entity.dart';

abstract class CanteenDetailsDataSource {
  Future<CanteenDetailsModel> fetchCanteenDetails(String uid);
}

final class CanteenDetailsDataSourceImpl implements CanteenDetailsDataSource {
  final FirebaseFirestore _fireStore;

  CanteenDetailsDataSourceImpl(this._fireStore);

  @override
  Future<CanteenDetailsModel> fetchCanteenDetails(String uid) async {
    final docRef =
        CloudFireStoreUtils.getOwnerCanteenInfoRef(_fireStore, uid: uid);
    final docSnapShot = await CloudFireStoreUtils.getDocument(docRef);
    if (docSnapShot.exists) {
      final canteenDetails = CanteenDetailsModel.fromJson(
          docSnapShot.data() as Map<String, dynamic>);
      return canteenDetails;
    } else {
      throw CanteenDetailsNoCanteenFoundException();
    }
  }
}
