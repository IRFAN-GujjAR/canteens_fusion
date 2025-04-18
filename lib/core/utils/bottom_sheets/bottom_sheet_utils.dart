import 'package:canteens_fusion/core/utils/permissions/custom_permission_handler_utils.dart';
import 'package:canteens_fusion/core/utils/print_utils.dart';
import 'package:canteens_fusion/core/widgets/bottom_sheets/pick_image_bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class BottomSheetUtils {
  static void showPickImage(BuildContext context, Function(XFile file) onResult,
      {bool cropImage = true,
      CropStyle cropStyle = CropStyle.rectangle,
      CropAspectRatio? aspectRatio,
      int quality = 50}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return PickImageBottomSheetWidget(
            onCameraImage: () async {
              final pickedFile = await _pickImage(ImageSource.camera);
              if (pickedFile == null) {
                if (context.mounted) {
                  if (!await CustomPermissionHandlerUtils.requestCamera(
                      context)) {
                    return;
                  }
                }
              }
              final resultFile = await _handleImageFile(
                pickedFile,
                cropImage: cropImage,
                aspectRatio: aspectRatio,
                quality: quality,
              );
              if (resultFile != null) {
                onResult(resultFile);
              }
              // }
            },
            onGalleryImage: () async {
              final pickedFile = await _pickImage(ImageSource.gallery);
              if (pickedFile == null) {
                if (context.mounted) {
                  if (!await CustomPermissionHandlerUtils.requestGallery(
                      context)) {
                    return;
                  }
                }
              }
              final resultFile = await _handleImageFile(
                pickedFile,
                cropImage: cropImage,
                aspectRatio: aspectRatio,
                quality: quality,
              );
              if (resultFile != null) {
                onResult(resultFile);
              }
            },
          );
        });
  }

  static Future<XFile?> _pickImage(ImageSource source) async {
    try {
      return await ImagePicker().pickImage(source: source);
    } catch (e) {
      printDebugMesg(dartFileName: 'BottomSheetUtils', msg: e.toString());
      return null;
    }
  }

  static Future<CroppedFile?> _cropImage(
      {required String path, CropAspectRatio? aspectRatio}) async {
    return await ImageCropper()
        .cropImage(sourcePath: path, aspectRatio: aspectRatio);
  }

  static Future<XFile?> _compressImage(
      {required String path, required int quality}) async {
    final newPath = p.join((await getTemporaryDirectory()).path,
        '${DateTime.now()}.${p.extension(path)}');
    return await FlutterImageCompress.compressAndGetFile(path, newPath,
        quality: quality);
  }

  static Future<XFile?> _handleImageFile(XFile? file,
      {required bool cropImage,
      required CropAspectRatio? aspectRatio,
      required int quality}) async {
    if (file != null) {
      if (cropImage) {
        final croppedImage =
            await _cropImage(path: file.path, aspectRatio: aspectRatio);
        if (croppedImage != null) {
          final compressedImage =
              await _compressImage(path: croppedImage.path, quality: quality);
          return compressedImage;
        }
      } else {
        final compressedImage =
            await _compressImage(path: file.path, quality: quality);
        return compressedImage;
      }
    }
    return null;
  }
}
