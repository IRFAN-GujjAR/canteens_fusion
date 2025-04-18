import 'package:canteens_fusion/core/constants/images_constants.dart';
import 'package:canteens_fusion/core/constants/user_type_constants.dart';
import 'package:canteens_fusion/core/utils/common_utils.dart';
import 'package:canteens_fusion/core/utils/navigation/navigation_utils.dart';
import 'package:canteens_fusion/core/utils/size_utils.dart';
import 'package:canteens_fusion/features/main/customer/customer_onboarding_page.dart';
import 'package:canteens_fusion/features/main/owner/owner_onboarding_page.dart';
import 'package:flutter/material.dart';

final class UserTypeSelectionPage extends StatelessWidget {
  const UserTypeSelectionPage({super.key});

  void _selectUser(
      {required BuildContext context, required UserType userType}) {
    NavigationUtils.navigate(
        context: context,
        page: userType == UserType.owner
            ? const OwnerOnboardingPage(
                onBoardingScreenNo: 1,
                onBoardingImagePath: ImageConstants.ownerOnBoarding1)
            : const CustomerOnboardingPage(
                onBoardingScreenNo: 1,
                onBoardingImagePath: ImageConstants.customerOnBoarding1,
              ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: getScreenPadding(includeTopPadding: false),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Are you a Canteen's",
                  style: TextStyle(fontSize: 24.fSize),
                ),
                SizedBox(height: 20.v),
                FilledButton(
                    onPressed: () {
                      _selectUser(context: context, userType: UserType.owner);
                    },
                    child: const Text('Owner')),
                SizedBox(height: 10.h),
                Text(
                  'or',
                  style: TextStyle(fontSize: 24.fSize),
                ),
                SizedBox(height: 10.h),
                FilledButton(
                  onPressed: () {
                    _selectUser(context: context, userType: UserType.customer);
                  },
                  child: const Text(
                    'Customer',
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
