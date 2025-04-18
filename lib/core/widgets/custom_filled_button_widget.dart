import 'package:canteens_fusion/core/utils/common_utils.dart';
import 'package:canteens_fusion/core/utils/size_utils.dart';
import 'package:canteens_fusion/core/widgets/jumping_dots_animation_widget.dart';
import 'package:flutter/material.dart';

final class CustomFilledButtonWidget extends StatelessWidget {
  final void Function() _onPressed;
  final Widget _child;
  final bool _bottomButton;
  final bool _isLoading;
  final bool _expandWidth;
  final bool _defaultButtonStyle;
  final bool _enableJumpingDotAnimation;

  const CustomFilledButtonWidget(
      {Key? key,
      required void Function() onPressed,
      required Widget child,
      bool bottomButton = false,
      bool isLoading = false,
      bool expandWidth = true,
      bool defaultButtonStyle = false,
      bool enableJumpingDotAnimation = true})
      : _onPressed = onPressed,
        _child = child,
        _bottomButton = bottomButton,
        _isLoading = isLoading,
        _expandWidth = expandWidth,
        _defaultButtonStyle = defaultButtonStyle,
        _enableJumpingDotAnimation = enableJumpingDotAnimation,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!_expandWidth && _isLoading) {
      return const JumpingDotsAnimationWidget();
    }
    final filledButton = FilledButton(
      style: _defaultButtonStyle
          ? const ButtonStyle()
          : ButtonStyle(
              padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(vertical: 20.v, horizontal: 20.h))),
      onPressed: _isLoading ? null : _onPressed,
      child: _isLoading && _enableJumpingDotAnimation
          ? SizedBox(
              height: 25.v,
              child: Stack(
                children: [
                  Center(
                    child: Visibility(
                        maintainState: true,
                        maintainAnimation: true,
                        visible: !_isLoading,
                        maintainSize: true,
                        child: _child),
                  ),
                  const JumpingDotsAnimationWidget()
                ],
              ),
            )
          : _child,
    );
    final button = !_expandWidth
        ? filledButton
        : SizedBox(width: double.maxFinite, child: filledButton);

    if (_bottomButton) {
      return Container(
        padding: getScreenPadding(),
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
        child: button,
      );
    }

    return button;
  }
}
