import 'package:canteens_fusion/core/constants/images_constants.dart';
import 'package:canteens_fusion/core/constants/user_type_constants.dart';
import 'package:canteens_fusion/core/utils/common_utils.dart';
import 'package:canteens_fusion/core/utils/navigation/navigation_utils.dart';
import 'package:canteens_fusion/core/utils/provider_utils.dart';
import 'package:canteens_fusion/core/utils/size_utils.dart';
import 'package:canteens_fusion/features/auth/presentation/provider/login_page_provider.dart';
import 'package:canteens_fusion/core/providers/user_session_provider.dart';
import 'package:canteens_fusion/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final class OwnerOnboardingPage extends StatelessWidget {
  final int _onBoardingScreenNo;
  final String _onBoardingImagePath;
  const OwnerOnboardingPage({
    Key? key,
    required int onBoardingScreenNo,
    required String onBoardingImagePath,
  })  : _onBoardingScreenNo = onBoardingScreenNo,
        _onBoardingImagePath = onBoardingImagePath,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: getScreenPadding(includeTopPadding: false),
        child: FutureBuilder(
            future: precacheImage(AssetImage(_onBoardingImagePath), context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(image: AssetImage(_onBoardingImagePath)),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 14.h, top: 10.v, right: 14.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _onBoardingScreenNo == 1
                                ? 'Register your canteen'
                                : 'Manage Your Canteen',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 36.fSize),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            height: 10.v,
                          ),
                          Text(
                            _onBoardingScreenNo == 1
                                ? 'Join Canteens Fusion'
                                : 'Effortlessly manage your canteen operations',
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 20.fSize),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 12.v, right: 12.h),
                          child: FilledButton(
                              onPressed: () {
                                if (_onBoardingScreenNo == 2) {
                                  ProviderUtils<UserSessionProvider>()
                                      .getProvider(context: context)
                                      .setUserType(userType: UserType.owner)
                                      .then((value) {
                                    NavigationUtils.navigate(
                                        context: context,
                                        removePreviousPages: true,
                                        page: ChangeNotifierProvider(
                                          create: (context) =>
                                              LoginPageProvider(),
                                          child: const LoginPage(),
                                        ));
                                  });
                                } else {
                                  NavigationUtils.navigate(
                                      context: context,
                                      page: OwnerOnboardingPage(
                                          onBoardingScreenNo:
                                              _onBoardingScreenNo + 1,
                                          onBoardingImagePath:
                                              ImageConstants.ownerOnBoarding2));
                                }
                              },
                              child: Text(_onBoardingScreenNo == 2
                                  ? 'Finish'
                                  : 'Next')),
                        )),
                  ],
                );
              }
              return Container();
            }),
      ),
    );
  }
}
