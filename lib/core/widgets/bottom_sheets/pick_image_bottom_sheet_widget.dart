import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PickImageBottomSheetWidget extends StatelessWidget {
  final void Function() onCameraImage;
  final void Function() onGalleryImage;

  const PickImageBottomSheetWidget(
      {Key? key, required this.onCameraImage, required this.onGalleryImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Camera'),
                onTap: () {
                  onCameraImage();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(FontAwesomeIcons.photoFilm),
                title: const Text('Gallery'),
                onTap: () {
                  onGalleryImage();
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}
