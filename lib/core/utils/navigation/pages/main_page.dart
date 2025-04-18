part of '../navigation_utils.dart';

Widget _mainPage(BuildContext context) {
  return context.read<UserSessionProvider>().userType.isCustomer
      ? const CustomerMainPage()
      : OwnerNavigationUtils.getNavigationPage(
        context,
        navigationPageType: OwnerNavigationPageType.checkCanteenDetails,
      );
}
