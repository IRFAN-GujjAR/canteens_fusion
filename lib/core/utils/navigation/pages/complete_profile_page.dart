part of '../navigation_utils.dart';

Widget get _completerProfilePage {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CompleteProfileProvider()),
      BlocProvider(
        create:
            (_) => CompleteProfileBloc(
              CompleteCustomerProfileUseCase(
                CompleteProfileRepoImpl(
                  CompleteProfileDataSourceImpl(
                    UserUpdateDataSourceImpl(
                      FirebaseAuthUtils.firebaseAuth,
                      CloudFireStoreUtils.fireStore,
                      FirebaseStorageUtils.firebaseStorage,
                    ),
                    FirebaseAuthUtils.firebaseAuth,
                  ),
                ),
              ),
            ),
      ),
    ],
    child: const CompleteProfilePage(),
  );
}
