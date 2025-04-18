import 'dart:io';
import 'package:canteens_fusion/core/constants/padding_constants.dart';
import 'package:canteens_fusion/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

bool get isIOS => Platform.isIOS;

EdgeInsets getScreenPadding(
    {bool includeTopPadding = true, bool onlyHorizontal = false}) {
  return EdgeInsets.only(
      left: PaddingConstants.screenLeftPadding.h,
      right: PaddingConstants.screenRightPadding.h,
      bottom: onlyHorizontal ? 0 : PaddingConstants.screenBottomPadding.sB,
      top: onlyHorizontal
          ? 0
          : includeTopPadding
              ? PaddingConstants.screenTopPadding
              : 0);
}

void hideKeyBoard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}
