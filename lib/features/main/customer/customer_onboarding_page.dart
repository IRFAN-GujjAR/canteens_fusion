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

final class CustomerOnboardingPage extends StatelessWidget {
  final int _onBoardingScreenNo;
  final String _onBoardingImagePath;
  const CustomerOnboardingPage({
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
                String mainMsg = 'Welcome to Canteens Fusion';
                String description =
                    'Discover a new way to order your favourite meals hassle-free';
                if (_onBoardingScreenNo == 2) {
                  mainMsg = 'Explore Menus';
                  description =
                      'Browse through a variety of cuisines and discover mouth-watering options';
                } else if (_onBoardingScreenNo == 3) {
                  mainMsg = 'Easy Ordering';
                  description =
                      'Select your favourite dishes and enjoy a seamless ordering experience';
                }
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
                            mainMsg,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 36.fSize),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            height: 10.v,
                          ),
                          Text(
                            description,
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
                                String imagePath = _onBoardingImagePath;
                                if (_onBoardingScreenNo == 1) {
                                  imagePath =
                                      ImageConstants.customerOnBoarding2;
                                } else if (_onBoardingScreenNo == 2) {
                                  imagePath =
                                      ImageConstants.customerOnBoarding3;
                                }
                                if (_onBoardingScreenNo == 3) {
                                  ProviderUtils<UserSessionProvider>()
                                      .getProvider(context: context)
                                      .setUserType(userType: UserType.customer)
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
                                      page: CustomerOnboardingPage(
                                          onBoardingScreenNo:
                                              _onBoardingScreenNo + 1,
                                          onBoardingImagePath: imagePath));
                                }
                              },
                              child: Text(_onBoardingScreenNo == 3
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
