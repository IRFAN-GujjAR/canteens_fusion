part of '../navigation_utils.dart';

Widget get _forgotPasswordPage {
  return MultiBlocProvider(
    providers: [
      BlocProvider<ForgotPasswordBloc>(
        create:
            (context) => ForgotPasswordBloc(
              SendPasswordResetEmailUseCase(
                ForgotPasswordRepoImpl(
                  ForgotPasswordDataSourceImpl(FirebaseAuthUtils.firebaseAuth),
                ),
              ),
            ),
      ),
      Provider<ForgotPasswordProvider>(
        create: (context) => ForgotPasswordProvider(),
      ),
    ],
    child: const ForgotPasswordPage(),
  );
}
