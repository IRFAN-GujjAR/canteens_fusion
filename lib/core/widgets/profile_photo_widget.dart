import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:canteens_fusion/core/widgets/icon_edit_button_widget.dart';
import 'package:canteens_fusion/core/widgets/profile_placeholder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

final class ProfilePhotoWidget extends StatelessWidget {
  final String? _profilePhotoUrl;
  final XFile? _profilePhotoFile;
  final void Function() _onEditPressed;
  final bool _isLoading;

  const ProfilePhotoWidget(
      {Key? key,
      required void Function() onEditPressed,
      String? profilePhotoUrl,
      XFile? profilePhotoFile,
      bool isLoading = false})
      : _onEditPressed = onEditPressed,
        _profilePhotoUrl = profilePhotoUrl,
        _profilePhotoFile = profilePhotoFile,
        _isLoading = isLoading,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 120,
      child: Stack(
        children: [
          Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: Colors.grey),
                // borderRadius: BorderRadius.circular(150)
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(500),
                child: _profilePhotoFile != null
                    ? Image.file(
                        File(_profilePhotoFile.path),
                        fit: BoxFit.fill,
                      )
                    : _profilePhotoUrl != null
                        ? true
                            ? CachedNetworkImage(
                                imageUrl: _profilePhotoUrl,
                                fit: BoxFit.fill,
                                errorWidget: (context, s, object) {
                                  return Container();
                                },
                                placeholder: (context, url) => Container(),
                              )
                            : Image.network(
                                _profilePhotoUrl,
                                fit: BoxFit.fill,
                              )
                        : const ProfilePlaceholderWidget(size: 80),
              )),
          Align(
            alignment: Alignment.bottomRight,
            child: IconEditButtonWidget(
              onPressed: _onEditPressed,
              isLoading: _isLoading,
            ),
          )
        ],
      ),
    );
  }
}
