import 'package:flutter/material.dart';

final class CustomTextButtonWidget extends StatelessWidget {
  final String _text;
  final void Function() _onPressed;
  final bool _isLoading;

  const CustomTextButtonWidget(
      {Key? key,
      required String text,
      required void Function() onPressed,
      bool isLoading = false})
      : _text = text,
        _onPressed = onPressed,
        _isLoading = isLoading,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: _isLoading ? null : _onPressed, child: Text(_text));
  }
}
