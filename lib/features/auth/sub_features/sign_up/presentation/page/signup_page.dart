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
import 'package:canteens_fusion/core/widgets/password_requirements_widget.dart';
import 'package:canteens_fusion/features/auth/sub_features/sign_up/presentation/bloc/signup_bloc.dart';
import 'package:canteens_fusion/features/auth/sub_features/sign_up/presentation/bloc/signup_states.dart';
import 'package:canteens_fusion/features/auth/sub_features/sign_up/presentation/provider/signup_page_provider.dart';
import 'package:canteens_fusion/core/providers/user_session_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

final class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userSessionProvider =
        ProviderUtils<UserSessionProvider>().getProvider(context: context);
    final signupPageProvider =
        ProviderUtils<SignupPageProvider>().getProvider(context: context);
    return GestureDetector(
      onTap: () => hideKeyBoard(context),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<SignupBloc, SignupState>(
          listener: (context, state) {
            switch (state) {
              case SignupInitialState():
              case RegisteringState():
                printDebugMesg(
                    dartFileName: runtimeType.toString(),
                    msg: state.toString());
                break;
              case UserSignupSuccessState():
                userSessionProvider.setCurrentUser = state.user;
                NavigationUtils.navigate(
                    context: context,
                    commonNavigationPageType:
                        CommonNavigationPageType.verifyEmail,
                    removePreviousPages: true);
                break;
              case SignupErrorState():
                DialogUtils.showErrorDialog(context, message: state.errorMsg);
                break;
            }
          },
          builder: (context, state) {
            final isLoading = state is RegisteringState;
            return Stack(
              children: [
                SingleChildScrollView(
                  padding: getScreenPadding(includeTopPadding: false),
                  child: Form(
                    key: signupPageProvider.formKey,
                    child: Column(
                      children: [
                        const Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 24),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10.v,
                        ),
                        Text(
                          'Create an account ${userSessionProvider.isUserOwner ? "for your canteen" : "to order food items from canteens in your area"}',
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 30.v,
                        ),
                        CustomTextFormFieldWidget(
                          enabled: !isLoading,
                          controller: signupPageProvider.emailTextController,
                          labelText: 'E-mail',
                          autofillHint: AutofillHints.email,
                          headingText: 'Enter your email',
                          suffixIcon: Icons.email,
                          validator: FormValidationUtils.emailValidator,
                        ),
                        SizedBox(
                          height: 20.v,
                        ),
                        Consumer<SignupPageProvider>(
                            builder: (context, pro, _) {
                          return CustomTextFormFieldWidget(
                            enabled: !isLoading,
                            controller:
                                signupPageProvider.passwordTextController,
                            labelText: 'Password',
                            autofillHint: AutofillHints.password,
                            headingText: 'Create a password',
                            obscureText: pro.hidePassword,
                            onChanged: pro.onPasswordChanged,
                            validator: signupPageProvider.passwordValidator,
                            suffixWidget: Padding(
                                padding: EdgeInsets.only(right: 12.h),
                                child: IconButton(
                                  icon: Icon(
                                    pro.hidePassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    pro.setHidePassword = !pro.hidePassword;
                                  },
                                )),
                          );
                        }),
                        SizedBox(
                          height: 15.v,
                        ),
                        Consumer<SignupPageProvider>(
                            builder: (context, pro, _) => Align(
                                  alignment: Alignment.topLeft,
                                  child: PasswordRequirementsWidget(
                                    signupPasswordEntity:
                                        pro.signupPasswordEntity,
                                  ),
                                )),
                        SizedBox(
                          height: 15.v,
                        ),
                        Consumer<SignupPageProvider>(
                            builder: (context, pro, _) {
                          return CustomTextFormFieldWidget(
                            enabled: !isLoading,
                            controller: signupPageProvider
                                .reEnterPasswordTextController,
                            labelText: 'Password',
                            autofillHint: AutofillHints.password,
                            headingText: 'Re-enter your password',
                            obscureText: pro.hideReEnterPassword,
                            validator:
                                signupPageProvider.reEnterPasswordValidator,
                            suffixWidget: Padding(
                                padding: EdgeInsets.only(right: 12.h),
                                child: IconButton(
                                  icon: Icon(
                                    pro.hideReEnterPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    pro.setHideReEnterPassword =
                                        !pro.hideReEnterPassword;
                                  },
                                )),
                          );
                        }),
                        SizedBox(
                          height: 150.v,
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomFilledButtonWidget(
                      bottomButton: true,
                      isLoading: isLoading,
                      onPressed: () {
                        hideKeyBoard(context);
                        signupPageProvider.onSignupPress(
                            signupBloc: context.read<SignupBloc>(),
                            userType: userSessionProvider.userType);
                      },
                      child: const Text('Sign Up')),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
