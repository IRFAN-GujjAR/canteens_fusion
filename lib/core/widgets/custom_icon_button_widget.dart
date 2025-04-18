import 'package:flutter/material.dart';

final class CustomIconButtonWidget extends StatelessWidget {
  final IconData _icon;
  final void Function() _onPressed;
  final bool _isLoading;

  const CustomIconButtonWidget(
      {Key? key,
      required IconData icon,
      required void Function() onPressed,
      bool isLoading = false})
      : _icon = icon,
        _onPressed = onPressed,
        _isLoading = isLoading,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _isLoading ? null : _onPressed,
      icon: Icon(_icon),
    );
  }
}
