import 'package:canteens_fusion/core/blocs/timer_bloc/timer_bloc.dart';
import 'package:canteens_fusion/core/constants/user_type_constants.dart';
import 'package:canteens_fusion/core/pages/user_type_selection_page.dart';
import 'package:canteens_fusion/core/providers/user_session_provider.dart';
import 'package:canteens_fusion/core/utils/firebase/auth/firebase_auth_utils.dart';
import 'package:canteens_fusion/core/utils/firebase/cloud_firestore/cloud_firestore_utils.dart';
import 'package:canteens_fusion/core/utils/firebase/storage/firebase_storage_utils.dart';
import 'package:canteens_fusion/core/utils/initialize_app_utils.dart';
import 'package:canteens_fusion/core/utils/navigation/navigation_pages_constants.dart';
import 'package:canteens_fusion/core/utils/navigation/owner/constants.dart';
import 'package:canteens_fusion/core/utils/navigation/owner/owner_navigation_utils.dart';
import 'package:canteens_fusion/core/utils/provider_utils.dart';
import 'package:canteens_fusion/core/utils/shared_pref/shared_pref_utils.dart';
import 'package:canteens_fusion/features/auth/data/datasources/local/auth_local_data_source.dart';
import 'package:canteens_fusion/features/auth/data/datasources/remote/auth_manage_remote_data_source.dart';
import 'package:canteens_fusion/features/auth/data/repositories/auth_manage_repo_impl.dart';
import 'package:canteens_fusion/features/auth/domain/usecases/auth_reload_user_usecase.dart';
import 'package:canteens_fusion/features/auth/presentation/pages/login_page.dart';
import 'package:canteens_fusion/features/auth/presentation/provider/login_page_provider.dart';
import 'package:canteens_fusion/features/auth/sub_features/forgot_password/data/datasources/forgot_password_data_source.dart';
import 'package:canteens_fusion/features/auth/sub_features/forgot_password/data/repositories/forgot_password_repo_impl.dart';
import 'package:canteens_fusion/features/auth/sub_features/forgot_password/domain/usecases/send_password_reset_email.dart';
import 'package:canteens_fusion/features/auth/sub_features/forgot_password/presentation/bloc/forgot_password_bloc.dart';
import 'package:canteens_fusion/features/auth/sub_features/forgot_password/presentation/pages/forgot_password_page.dart';
import 'package:canteens_fusion/features/auth/sub_features/forgot_password/presentation/provider/forgot_password_provider.dart';
import 'package:canteens_fusion/features/auth/sub_features/sign_up/data/data_sources/signup_data_source.dart';
import 'package:canteens_fusion/features/auth/sub_features/sign_up/data/repositories/signup_repo_impl.dart';
import 'package:canteens_fusion/features/auth/sub_features/sign_up/domain/usecases/register_user_use_case.dart';
import 'package:canteens_fusion/features/auth/sub_features/sign_up/presentation/bloc/signup_bloc.dart';
import 'package:canteens_fusion/features/auth/sub_features/sign_up/presentation/page/signup_page.dart';
import 'package:canteens_fusion/features/auth/sub_features/sign_up/presentation/provider/signup_page_provider.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/data/datasources/user_update_data_source.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/data/repositories/user_update_repo_impl.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/email_verified/usecase.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/phone_number/usecase.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/presentation/bloc/user_update_bloc.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_email/data/datasources/verify_email_data_source.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_email/data/repositories/verify_email_repo_impl.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_email/domain/usecases/send_verify_email_usecase.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_email/presentation/bloc/verify_email_bloc.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_email/presentation/bloc/verify_email_events.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_email/presentation/pages/verify_email_page.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_phone_number/data/datasources/verify_phone_number_data_source.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_phone_number/data/repositories/verify_phone_number_repo_impl.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_phone_number/domain/usecases/send_otp_use_case.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_phone_number/domain/usecases/verify_otp_use_case.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_phone_number/presentation/bloc/verify_phone_number_bloc.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_phone_number/presentation/pages/verify_phone_number_page.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_phone_number/presentation/provider/verify_phone_number_provider.dart';
import 'package:canteens_fusion/features/main/customer/main/customer_main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/auth/sub_features/complete_profile/data/data_sources/complete_profile_data_source.dart';
import '../../../features/auth/sub_features/complete_profile/data/repositories/complete_profile_repo_impl.dart';
import '../../../features/auth/sub_features/complete_profile/domain/use_cases/complete_customer_profile_use_case.dart';
import '../../../features/auth/sub_features/complete_profile/presentation/bloc/complete_profile_bloc.dart';
import '../../../features/auth/sub_features/complete_profile/presentation/pages/complete_profile_page.dart';
import '../../../features/auth/sub_features/complete_profile/presentation/providers/complete_profile_provider.dart';

part 'pages/complete_profile_page.dart';
part 'pages/forgot_password_page.dart';
part 'pages/login_page.dart';
part 'pages/main_page.dart';
part 'pages/signup_page.dart';
part 'pages/verify_email_page.dart';
part 'pages/verify_phone_number_page.dart';

final class NavigationUtils {
  static void navigate({
    required BuildContext context,
    bool rootNavigator = false,
    Widget? page,
    bool removePreviousPages = false,
    bool replacePage = false,
    bool fullScreenDialog = false,
    CommonNavigationPageType? commonNavigationPageType,
    OwnerNavigationPageType? ownerNavigationPageType,
  }) {
    if (page == null &&
        commonNavigationPageType == null &&
        ownerNavigationPageType == null) {
      throw ('One of these(Page,CommonNavigationPageType, and OwnerNavigationPageType)'
          ' needs not to be null Page and NavigationPageType cannot be null');
    } else if ((page != null &&
            commonNavigationPageType != null &&
            ownerNavigationPageType != null) ||
        (page != null && commonNavigationPageType != null) ||
        (page != null && ownerNavigationPageType != null) ||
        (commonNavigationPageType != null && ownerNavigationPageType != null)) {
      throw ('Only one of the parameters can be non-null at a time');
    }
    if (commonNavigationPageType != null) {
      page = getNavigationPage(
        context,
        navigationPageType: commonNavigationPageType,
      );
    } else if (ownerNavigationPageType != null) {
      page = OwnerNavigationUtils.getNavigationPage(
        context,
        navigationPageType: ownerNavigationPageType,
      );
    }
    final route = MaterialPageRoute(
      fullscreenDialog: fullScreenDialog,
      builder: (_) => page!,
    );
    if (removePreviousPages) {
      Navigator.of(
        context,
        rootNavigator: rootNavigator,
      ).pushAndRemoveUntil(route, (route) => false);
    } else if (replacePage) {
      Navigator.of(
        context,
        rootNavigator: rootNavigator,
      ).pushReplacement(route);
    } else {
      Navigator.of(context, rootNavigator: rootNavigator).push(route);
    }
  }

  static void navigateToRoot(BuildContext context) {
    var navigator = Navigator.of(context);
    while (navigator.canPop()) {
      navigator.pop();
    }
  }

  static void navigateBack(BuildContext context, {int numberOfScreens = 1}) {
    int count = 0;
    Navigator.of(context).popUntil((_) => count++ >= numberOfScreens);
  }

  static Widget getNavigationPage(
    BuildContext context, {
    required CommonNavigationPageType navigationPageType,
    bool usePreviousDependencies = false,
  }) {
    switch (navigationPageType) {
      case CommonNavigationPageType.login:
        return _loginPage(context);
      case CommonNavigationPageType.signup:
        return _signupPage(context);
      case CommonNavigationPageType.verifyEmail:
        return _verifyEmailPage(context);
      case CommonNavigationPageType.verifyPhoneNumber:
        return _verifyPhoneNumberPage(context, usePreviousDependencies);
      case CommonNavigationPageType.userTypeSelection:
        return const UserTypeSelectionPage();
      case CommonNavigationPageType.completeProfile:
        return _completerProfilePage;
      case CommonNavigationPageType.main:
        return _mainPage(context);
      case CommonNavigationPageType.pageAfterLoggedIn:
        return getNavigationPage(
          context,
          navigationPageType: getPageAfterLoggedIn(context),
        );
      case CommonNavigationPageType.forgotPassword:
        return _forgotPasswordPage;
    }
  }

  static CommonNavigationPageType getPageAfterLoggedIn(BuildContext context) {
    final provider = ProviderUtils<UserSessionProvider>().getProvider(
      context: context,
    );
    final user = provider.currentUser!;
    var navigationPageType = CommonNavigationPageType.login;
    if (!user.isEmailVerified) {
      navigationPageType = CommonNavigationPageType.verifyEmail;
    } else if (!user.isPhoneNumberVerified) {
      navigationPageType = CommonNavigationPageType.verifyPhoneNumber;
    } else if (!user.isSignupCompleted) {
      navigationPageType = CommonNavigationPageType.completeProfile;
    } else {
      navigationPageType = CommonNavigationPageType.main;
    }
    return navigationPageType;
  }
}
