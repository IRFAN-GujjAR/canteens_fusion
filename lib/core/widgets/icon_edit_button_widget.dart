import 'package:canteens_fusion/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

final class IconEditButtonWidget extends StatelessWidget {
  final void Function() _onPressed;
  final bool _isLoading;

  const IconEditButtonWidget(
      {Key? key, required Function() onPressed, bool isLoading = false})
      : _onPressed = onPressed,
        _isLoading = isLoading,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.grey;
          }
          return const Color(AppColors.seedColor);
        })),
        color: Colors.white,
        onPressed: _isLoading ? null : _onPressed,
        icon: const Icon(Icons.edit));
  }
}
