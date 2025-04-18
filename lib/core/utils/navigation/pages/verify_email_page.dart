part of '../navigation_utils.dart';

Widget _verifyEmailPage(BuildContext context) {
  final provider = context.read<UserSessionProvider>();
  return MultiBlocProvider(
    providers: [
      BlocProvider(
        create:
            (_) => VerifyEmailBloc(
              SendVerifyEmailUseCase(
                VerifyEmailRepoImpl(
                  VerifyEmailDataSourceImpl(FirebaseAuthUtils.firebaseAuth),
                ),
              ),
              AuthReloadUserUseCase(
                AuthManageRepoImpl(
                  AuthLocalDataSourceImpl(
                    firebaseAuth: FirebaseAuthUtils.firebaseAuth,
                    prefs: locator.get<SharedPreferences>(),
                    prefsUtils: locator.get<SharedPrefUtils>(),
                  ),
                  AuthManageRemoteDataSourceImpl(
                    FirebaseAuthUtils.firebaseAuth,
                  ),
                ),
              ),
              UserUpdateEmailVerifiedUseCase(
                UserUpdateRepoImpl(
                  UserUpdateDataSourceImpl(
                    FirebaseAuthUtils.firebaseAuth,
                    CloudFireStoreUtils.fireStore,
                    FirebaseStorageUtils.firebaseStorage,
                  ),
                ),
              ),
              userType: context.read<UserSessionProvider>().userType,
            )..add(SendEmailVerifyEmailEvent(user: provider.getCurrentUser)),
      ),
      BlocProvider<TimerBloc>(create: (context) => TimerBloc(seconds: 60)),
    ],
    child: const VerifyEmailPage(),
  );
}
