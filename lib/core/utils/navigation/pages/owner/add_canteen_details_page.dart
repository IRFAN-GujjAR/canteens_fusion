part of '../../owner/owner_navigation_utils.dart';

Widget get _addCanteenDetailsPage {
  final addCanteenDetailsProvider = AddCanteenDetailsProvider();
  final addCanteenAddressProvider = AddCanteenAddressProvider();
  final geocodingBloc = GeocodingBloc(
    ConvertLatLongToAddressUseCase(
      GeocodingRepoImpl(GeocodingDataSourceImpl()),
    ),
  );
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => addCanteenDetailsProvider),
      ChangeNotifierProvider(create: (_) => addCanteenAddressProvider),
      BlocProvider(create: (_) => geocodingBloc),
    ],
    child: const AddCanteenDetailsPage(),
  );
}
