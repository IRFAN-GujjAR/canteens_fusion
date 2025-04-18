import 'package:canteens_fusion/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';

final class JumpingDotsAnimationWidget extends StatelessWidget {
  const JumpingDotsAnimationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return JumpingDots(
      radius: 7,
      color: const Color(AppColors.seedColor),
    );
  }
}
