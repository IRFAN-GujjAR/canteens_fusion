import 'package:canteens_fusion/core/constants/images_constants.dart';
import 'package:canteens_fusion/core/constants/user_type_constants.dart';
import 'package:canteens_fusion/core/utils/common_utils.dart';
import 'package:canteens_fusion/core/utils/dialogs/dialogs_utils.dart';
import 'package:canteens_fusion/core/utils/form_validation/form_validation_utils.dart';
import 'package:canteens_fusion/core/utils/navigation/navigation_pages_constants.dart';
import 'package:canteens_fusion/core/utils/navigation/navigation_utils.dart';
import 'package:canteens_fusion/core/utils/print_utils.dart';
import 'package:canteens_fusion/core/utils/provider_utils.dart';
import 'package:canteens_fusion/core/utils/size_utils.dart';
import 'package:canteens_fusion/core/widgets/custom_filled_button_widget.dart';
import 'package:canteens_fusion/core/widgets/custom_text_form_field.dart';
import 'package:canteens_fusion/core/widgets/divider_widget.dart';
import 'package:canteens_fusion/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:canteens_fusion/features/auth/presentation/provider/login_page_provider.dart';
import 'package:canteens_fusion/core/providers/user_session_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

final class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider =
        ProviderUtils<LoginPageProvider>().getProvider(context: context);
    final userSessionProvider = ProviderUtils<UserSessionProvider>()
        .getProvider(context: context, listen: true);
    final userType = userSessionProvider.userType;
    final userTypeName = userSessionProvider.userTypeName;
    return GestureDetector(
      onTap: () => hideKeyBoard(context),
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          padding: getScreenPadding(includeTopPadding: false),
          child: Center(
            child: Form(
              key: provider.formKey,
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  switch (state) {
                    case AuthInitialState():
                    case AuthLoggingInState():
                      printDebugMesg(
                          dartFileName: runtimeType.toString(),
                          msg: (state).toString());
                      break;
                    case UserLoggedInState():
                      final user = state.user;
                      userSessionProvider.setCurrentUser = user;
                      NavigationUtils.navigate(
                          context: context,
                          commonNavigationPageType:
                              CommonNavigationPageType.pageAfterLoggedIn,
                          removePreviousPages: true);
                      break;
                    case AuthWrongUserTypeErrorState():
                      printDebugMesg(
                          dartFileName: runtimeType.toString(),
                          msg: state.toString());
                      DialogUtils.showErrorDialog(context,
                          message: state.errorMsg);
                      break;
                    case AuthLoginErrorState():
                      printDebugMesg(
                          dartFileName: runtimeType.toString(),
                          msg: state.toString());
                      DialogUtils.showErrorDialog(context,
                          message: state.errorMsg);
                      break;
                  }
                },
                builder: (context, state) {
                  final isLoading = (state is AuthLoggingInState);
                  return Column(
                    children: [
                      Image.asset(ImageConstants.appLogo),
                      SizedBox(
                        height: 12.v,
                      ),
                      Image.asset(ImageConstants.bottomLogo),
                      SizedBox(
                        height: 20.v,
                      ),
                      Text("Login as a $userTypeName"),
                      SizedBox(
                        height: 20.v,
                      ),
                      CustomTextFormFieldWidget(
                        enabled: !isLoading,
                        controller: provider.emailTextController,
                        labelText: 'E-mail',
                        autofillHint: AutofillHints.email,
                        suffixIcon: Icons.email,
                        headingText: 'Enter your email',
                        validator: FormValidationUtils.emailValidator,
                      ),
                      SizedBox(
                        height: 12.v,
                      ),
                      Consumer<LoginPageProvider>(builder: (context, pro, _) {
                        return CustomTextFormFieldWidget(
                          enabled: !isLoading,
                          controller: provider.passwordTextController,
                          labelText: 'Password',
                          autofillHint: AutofillHints.password,
                          suffixIcon: Icons.abc,
                          headingText: 'Enter your password',
                          validator: FormValidationUtils.passwordLoginValidator,
                          obscureText: pro.hidePassword,
                          suffixWidget: Padding(
                              padding: EdgeInsets.only(right: 12.h),
                              child: IconButton(
                                icon: Icon(
                                  pro.hidePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  provider.setHidePassword =
                                      !provider.hidePassword;
                                },
                              )),
                        );
                      }),
                      SizedBox(
                        height: 16.v,
                      ),
                      CustomFilledButtonWidget(
                          isLoading: isLoading,
                          onPressed: () {
                            hideKeyBoard(context);
                            provider.onLoginPress(
                                authBloc: context.read<AuthBloc>(),
                                userType: userType);
                          },
                          child: const Text(
                            'Login',
                          )),
                      TextButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  NavigationUtils.navigate(
                                      context: context,
                                      commonNavigationPageType:
                                          CommonNavigationPageType
                                              .forgotPassword);
                                },
                          child: const Text(
                            'Forgot Password',
                          )),
                      Row(
                        children: [
                          const Expanded(child: DividerWidget()),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.h),
                            child: Text(
                              'or',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                          ),
                          const Expanded(child: DividerWidget())
                        ],
                      ),
                      TextButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  var type = UserType.none;
                                  if (userType == UserType.customer) {
                                    type = UserType.owner;
                                  } else {
                                    type = UserType.customer;
                                  }
                                  userSessionProvider
                                      .setUserType(userType: type)
                                      .then((value) {
                                    NavigationUtils.navigate(
                                        context: context,
                                        page: ChangeNotifierProvider<
                                            LoginPageProvider>(
                                          create: (_) => LoginPageProvider(),
                                          child: const LoginPage(),
                                        ),
                                        replacePage: true);
                                  });
                                },
                          child: Text(
                            'Change user to ${userType == UserType.customer ? 'Owner' : 'Customer'}',
                          )),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'New User?',
                            style: TextStyle(color: Colors.grey),
                          ),
                          TextButton(
                              onPressed: isLoading
                                  ? null
                                  : () {
                                      NavigationUtils.navigate(
                                          context: context,
                                          commonNavigationPageType:
                                              CommonNavigationPageType.signup);
                                    },
                              child: const Text('Create Account'))
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
