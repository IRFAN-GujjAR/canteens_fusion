part of '../../owner/owner_navigation_utils.dart';

Widget _addCanteenAddressPage(BuildContext context) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider.value(
        value: context.read<AddCanteenDetailsProvider>(),
      ),
      ChangeNotifierProvider.value(
        value: context.read<AddCanteenAddressProvider>(),
      ),
      BlocProvider.value(value: context.read<GeocodingBloc>()),
    ],
    child: const AddCanteenAddressPage(),
  );
}
