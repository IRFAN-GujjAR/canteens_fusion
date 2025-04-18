part of '../navigation_utils.dart';

Widget _verifyPhoneNumberPage(
  BuildContext context,
  bool usePreviousDependencies,
) {
  if (usePreviousDependencies) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<VerifyPhoneNumberBloc>.value(
          value: context.read<VerifyPhoneNumberBloc>(),
        ),
        ChangeNotifierProvider.value(
          value: context.read<VerifyPhoneNumberPageProvider>(),
        ),
        BlocProvider<UserUpdateBloc>.value(
          value: context.read<UserUpdateBloc>(),
        ),
        BlocProvider<TimerBloc>.value(value: context.read<TimerBloc>()),
      ],
      child: const VerifyPhoneNumberPage(),
    );
  } else {
    final verifyPhoneNumberRepo = VerifyPhoneNumberRepoImpl(
      VerifyPhoneNumberDataSourceImpl(FirebaseAuthUtils.firebaseAuth),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider<VerifyPhoneNumberBloc>(
          create:
              (context) => VerifyPhoneNumberBloc(
                VerifyPhoneNumberSendOtpUseCase(verifyPhoneNumberRepo),
                VerifyPhoneNumberVerifyOtpUseCase(verifyPhoneNumberRepo),
                UserUpdatePhoneNumberUseCase(
                  UserUpdateRepoImpl(
                    UserUpdateDataSourceImpl(
                      FirebaseAuthUtils.firebaseAuth,
                      CloudFireStoreUtils.fireStore,
                      FirebaseStorageUtils.firebaseStorage,
                    ),
                  ),
                ),
              ),
        ),
        ChangeNotifierProvider(
          create: (context) => VerifyPhoneNumberPageProvider(),
        ),
        BlocProvider<UserUpdateBloc>(
          create:
              (_) => UserUpdateBloc(
                userUpdateRepo: UserUpdateRepoImpl(
                  UserUpdateDataSourceImpl(
                    FirebaseAuthUtils.firebaseAuth,
                    CloudFireStoreUtils.fireStore,
                    FirebaseStorageUtils.firebaseStorage,
                  ),
                ),
              ),
        ),
        BlocProvider<TimerBloc>(create: (_) => TimerBloc(seconds: 60)),
      ],
      child: const VerifyPhoneNumberPage(),
    );
  }
}
