import 'package:canteens_fusion/core/constants/images_constants.dart';
import 'package:canteens_fusion/core/utils/common_utils.dart';
import 'package:canteens_fusion/core/utils/dialogs/dialogs_utils.dart';
import 'package:canteens_fusion/core/utils/form_validation/form_validation_utils.dart';
import 'package:canteens_fusion/core/utils/navigation/navigation_utils.dart';
import 'package:canteens_fusion/core/utils/print_utils.dart';
import 'package:canteens_fusion/core/utils/provider_utils.dart';
import 'package:canteens_fusion/core/utils/size_utils.dart';
import 'package:canteens_fusion/core/widgets/custom_filled_button_widget.dart';
import 'package:canteens_fusion/core/widgets/custom_text_form_field.dart';
import 'package:canteens_fusion/features/auth/sub_features/forgot_password/presentation/bloc/forgot_password_bloc.dart';
import 'package:canteens_fusion/features/auth/sub_features/forgot_password/presentation/bloc/forgot_password_states.dart';
import 'package:canteens_fusion/features/auth/sub_features/forgot_password/presentation/provider/forgot_password_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: getScreenPadding(),
          child: FutureBuilder(
              future: precacheImage(
                  const AssetImage(ImageConstants.forgotPassword), context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Center(
                    child: Column(
                      children: [
                        Image.asset(ImageConstants.forgotPassword),
                        SizedBox(
                          height: 30.v,
                        ),
                        BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
                          listener: (context, state) {
                            switch (state) {
                              case InitialForgotPasswordState():
                              case SendingEmailForgotPasswordState():
                                printDebugMesg(
                                    dartFileName: runtimeType.toString(),
                                    msg: state.toString());
                                break;
                              case EmailSentForgotPasswordState():
                                DialogUtils.showMessageDialog(context,
                                        title: 'Password Reset',
                                        message:
                                            "A password reset email is sent to ${state.email}."
                                            " If you don't find mail in your inbox then check your spam folder or"
                                            " check whether you entered email correctly or not.")
                                    .then((value) {
                                  NavigationUtils.navigateBack(context);
                                });
                                break;
                              case ErrorForgotPasswordState():
                                DialogUtils.showErrorDialog(context,
                                    message: state.errorMsg);
                                break;
                            }
                          },
                          builder: (context, state) {
                            final isLoading =
                                state is SendingEmailForgotPasswordState;
                            final provider =
                                ProviderUtils<ForgotPasswordProvider>()
                                    .getProvider(context: context);
                            return Form(
                              key: provider.formKey,
                              child: Column(
                                children: [
                                  CustomTextFormFieldWidget(
                                    enabled: !isLoading,
                                    controller: provider.emailTextController,
                                    labelText: 'E-mail',
                                    autofillHint: AutofillHints.email,
                                    suffixIcon: Icons.email,
                                    headingText: 'Enter your email',
                                    validator:
                                        FormValidationUtils.emailValidator,
                                  ),
                                  SizedBox(
                                    height: 20.v,
                                  ),
                                  CustomFilledButtonWidget(
                                      isLoading: isLoading,
                                      onPressed: () {
                                        provider
                                            .sendPasswordResetEmail(context);
                                      },
                                      child: const Text(
                                          'Send Password Reset Email'))
                                ],
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  );
                }
                return Container();
              }),
        ),
      ),
    );
  }
}
