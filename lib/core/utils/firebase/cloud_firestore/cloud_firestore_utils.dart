import 'package:canteens_fusion/core/constants/user_type_constants.dart';
import 'package:canteens_fusion/core/utils/initialize_app_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final class CloudFireStoreUtils {
  static const _requestTimeOutSeconds = Duration(seconds: 5);

  static const _ownersProfiles = 'Owners_Profiles';
  static const _customersProfiles = 'Customers_Profiles';
  static const _canteens = 'Canteens';

  static FirebaseFirestore get fireStore => locator.get<FirebaseFirestore>();

  static DocumentReference getUserReference(FirebaseFirestore fireStore,
      {required UserType userType, required String uid}) {
    return fireStore
        .collection(userType.isCustomer ? _customersProfiles : _ownersProfiles)
        .doc(uid);
  }

  static DocumentReference getOwnerCanteenInfoRef(FirebaseFirestore fireStore,
      {required String uid}) {
    return fireStore.collection(_canteens).doc(uid);
  }

  static Future<DocumentSnapshot<Object?>> getDocument(
      DocumentReference ref) async {
    return await ref.get().timeout(_requestTimeOutSeconds);
  }

  static Future<void> setDocument(DocumentReference ref,
      {required Object? data}) async {
    await ref.set(data).timeout(_requestTimeOutSeconds);
  }

  static Future<void> updateDocument(DocumentReference ref,
      {required Map<Object, Object?> data}) async {
    await ref.update(data).timeout(_requestTimeOutSeconds);
  }
}
