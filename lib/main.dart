import 'package:canteens_fusion/core/constants/app_colors.dart';
import 'package:canteens_fusion/core/providers/user_session_provider.dart';
import 'package:canteens_fusion/core/utils/initialize_app_utils.dart';
import 'package:canteens_fusion/core/utils/navigation/navigation_pages_constants.dart';
import 'package:canteens_fusion/core/utils/navigation/navigation_utils.dart';
import 'package:canteens_fusion/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:canteens_fusion/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  runApp(await initializeFlutterApp);
}

final class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget _getHomePage(BuildContext context) {
    final provider = Provider.of<UserSessionProvider>(context, listen: false);
    CommonNavigationPageType homePage =
        CommonNavigationPageType.userTypeSelection;
    if (provider.isUserTypeSelected) {
      if (provider.isUserLoggedIn) {
        homePage = NavigationUtils.getPageAfterLoggedIn(context);
      } else {
        homePage = CommonNavigationPageType.login;
      }
    }
    return NavigationUtils.getNavigationPage(
      context,
      navigationPageType: homePage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(locator.get<AuthRepoImpl>()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Canteens Fusion',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(AppColors.seedColor),
          ),
          fontFamily: 'Lexend',
          useMaterial3: true,
        ),
        home: _getHomePage(context),
      ),
    );
  }
}
