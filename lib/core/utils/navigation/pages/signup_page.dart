part of '../navigation_utils.dart';

Widget _signupPage(BuildContext context) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => SignupPageProvider()),
      BlocProvider(
        create:
            (_) => SignupBloc(
              SignupRegisterUserUseCase(
                SignupRepoImpl(
                  SignupDataSourceImpl(
                    FirebaseAuthUtils.firebaseAuth,
                    CloudFireStoreUtils.fireStore,
                  ),
                ),
              ),
            ),
      ),
    ],
    child: const SignupPage(),
  );
}
