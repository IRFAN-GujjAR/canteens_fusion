part of '../../owner/owner_navigation_utils.dart';

Widget _checkCanteenDetailsPage(BuildContext context) {
  context.read<CanteenDetailsBloc>().add(
    CanteenDetailsEventFetch(
      context.read<UserSessionProvider>().currentUser!.uid,
    ),
  );
  return const CheckCanteenDetailsPage();
}
