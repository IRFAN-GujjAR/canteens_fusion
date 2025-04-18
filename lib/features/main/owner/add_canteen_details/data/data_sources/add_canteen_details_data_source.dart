import 'package:canteens_fusion/core/utils/file_utils.dart';
import 'package:canteens_fusion/core/utils/firebase/cloud_firestore/cloud_firestore_utils.dart';
import 'package:canteens_fusion/core/utils/firebase/storage/firebase_storage_utils.dart';
import 'package:canteens_fusion/core/utils/print_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import '../models/canteen_details_model.dart';

abstract class AddCanteenDetailsDataSource {
  Future<CanteenDetailsModel> addCanteenDetails(String uid,
      XFile canteenMainImageFile, CanteenDetailsModel canteenDetails);
}

final class AddCanteenDetailsDataSourceImpl
    implements AddCanteenDetailsDataSource {
  final FirebaseStorage _firebaseStorage;
  final FirebaseFirestore _firebaseFireStore;

  AddCanteenDetailsDataSourceImpl(
      this._firebaseStorage, this._firebaseFireStore);

  @override
  Future<CanteenDetailsModel> addCanteenDetails(
      String uid, XFile file, CanteenDetailsModel canteenDetails) async {
    final fileUrl = await FirebaseStorageUtils.uploadFile(
        storage: _firebaseStorage,
        ref: FirebaseStorageUtils.canteenMainImageRef(
            storage: _firebaseStorage,
            uid: uid,
            fileName:
                FileUtils.getFileName(file: file, fileName: 'main_image')),
        file: file);
    final ref = CloudFireStoreUtils.getOwnerCanteenInfoRef(_firebaseFireStore,
        uid: uid);
    final updatedDetails = canteenDetails.updateCanteenPhotoUrl(fileUrl);
    await ref.set(updatedDetails.toJson());
    return updatedDetails;
  }
}
