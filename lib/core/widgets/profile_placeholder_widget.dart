import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final class ProfilePlaceholderWidget extends StatelessWidget {
  final double _size;

  const ProfilePlaceholderWidget({Key? key, required double size})
      : _size = size,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      CupertinoIcons.person_solid,
      size: _size,
      color: Colors.grey[800],
    );
  }
}
