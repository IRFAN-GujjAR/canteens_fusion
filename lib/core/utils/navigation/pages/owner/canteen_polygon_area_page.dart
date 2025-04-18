part of '../../owner/owner_navigation_utils.dart';

Widget _canteenPolygonAreaPage(BuildContext context) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider.value(
        value: context.read<AddCanteenDetailsProvider>(),
      ),
      ChangeNotifierProvider.value(
        value: context.read<AddCanteenAddressProvider>(),
      ),
      ChangeNotifierProvider(create: (_) => CanteenPolygonAreaProvider()),
      BlocProvider.value(value: context.read<GeocodingBloc>()),
      BlocProvider(
        create:
            (_) => AddCanteenDetailsBloc(
              AddCanteenDetailsUseCase(
                AddCanteenDetailsRepoImpl(
                  AddCanteenDetailsDataSourceImpl(
                    FirebaseStorageUtils.firebaseStorage,
                    CloudFireStoreUtils.fireStore,
                  ),
                ),
              ),
            ),
      ),
    ],
    child: const CanteenPolygonAreaPage(),
  );
}
