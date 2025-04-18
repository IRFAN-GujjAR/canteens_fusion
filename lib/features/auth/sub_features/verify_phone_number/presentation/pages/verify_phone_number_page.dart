import 'package:canteens_fusion/core/blocs/timer_bloc/timer_bloc.dart';
import 'package:canteens_fusion/core/constants/images_constants.dart';
import 'package:canteens_fusion/core/utils/common_utils.dart';
import 'package:canteens_fusion/core/utils/form_validation/form_validation_utils.dart';
import 'package:canteens_fusion/core/utils/provider_utils.dart';
import 'package:canteens_fusion/core/utils/size_utils.dart';
import 'package:canteens_fusion/core/utils/text_input_formatters/phone_number_input_formatter.dart';
import 'package:canteens_fusion/core/widgets/custom_filled_button_widget.dart';
import 'package:canteens_fusion/core/widgets/custom_text_button_widget.dart';
import 'package:canteens_fusion/core/widgets/custom_text_form_field.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_phone_number/presentation/bloc/verify_phone_number_bloc.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_phone_number/presentation/provider/verify_phone_number_provider.dart';
import 'package:canteens_fusion/core/providers/user_session_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

final class VerifyPhoneNumberPage extends StatelessWidget {
  const VerifyPhoneNumberPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final verifyPhoneNumberProvider =
        ProviderUtils<VerifyPhoneNumberPageProvider>()
            .getProvider(context: context);
    return GestureDetector(
      onTap: () => hideKeyBoard(context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: BlocConsumer<VerifyPhoneNumberBloc, VerifyPhoneNumberState>(
            listener: (context, state) {
          verifyPhoneNumberProvider.handleVerifyPhoneNumberBloc(context, state);
        }, builder: (context, state) {
          return Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImageConstants.enterResetCode,
                      scale: 1.8,
                    ),
                    SizedBox(
                      height: 12.v,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 230.v),
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: verifyPhoneNumberProvider.pageController,
                  children: [
                    Padding(
                      padding: getScreenPadding(onlyHorizontal: true),
                      child: Form(
                        key: verifyPhoneNumberProvider.phoneNumberFormKey,
                        child: Column(
                          children: [
                            const Text(
                              'You need yo verify your phone number before you continue using app',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(
                              height: 15.v,
                            ),
                            CustomTextFormFieldWidget(
                              enabled:
                                  !verifyPhoneNumberProvider.isLoading(state),
                              controller: verifyPhoneNumberProvider
                                  .phoneNumberTextController,
                              labelText: 'Mobile Number',
                              hintText: '+92 ##########',
                              autofillHint: AutofillHints.telephoneNumber,
                              headingText: 'Enter your mobile number',
                              suffixIcon: Icons.phone,
                              onChanged: (value) {
                                verifyPhoneNumberProvider
                                    .setShowForwardNavigationArrow = false;
                              },
                              validator:
                                  FormValidationUtils.phoneNumberValidator,
                              inputFormatters: [
                                PhoneNumberInputFormatter().phoneNumberFormatter
                              ],
                            ),
                            SizedBox(
                              height: 30.v,
                            ),
                            BlocBuilder<TimerBloc, TimerState>(
                              builder: (context, timerState) {
                                final button = CustomFilledButtonWidget(
                                    onPressed: () {
                                      verifyPhoneNumberProvider.sendOtp(context,
                                          verifyPhoneNumberBloc: context
                                              .read<VerifyPhoneNumberBloc>());
                                    },
                                    isLoading: verifyPhoneNumberProvider
                                        .isLoading(state,
                                            timerState: timerState),
                                    child: const Text('Send Code'));
                                if (timerState is TimerRunningState) {
                                  return Column(
                                    children: [
                                      Text(
                                          'Resend code in ${timerState.secondsRemaining} seconds'),
                                      SizedBox(
                                        height: 20.v,
                                      ),
                                      button
                                    ],
                                  );
                                }
                                return button;
                              },
                            ),
                            Consumer<VerifyPhoneNumberPageProvider>(
                                builder: (context, provider, _) {
                              if (provider.showForwardNavigationArrow) {
                                return Padding(
                                  padding: EdgeInsets.only(top: 30.v),
                                  child: IconButton(
                                    onPressed: verifyPhoneNumberProvider
                                            .isLoading(state)
                                        ? null
                                        : () {
                                            verifyPhoneNumberProvider
                                                .navigateToOtpPage;
                                          },
                                    icon: const Icon(Icons.arrow_forward),
                                  ),
                                );
                              }
                              return Container();
                            }),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: getScreenPadding(onlyHorizontal: true),
                      child: Column(
                        children: [
                          Consumer<VerifyPhoneNumberPageProvider>(
                              builder: (context, provider, _) {
                            return Text(
                              'Verification code is sent to ${provider.phoneNumber}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 12),
                            );
                          }),
                          SizedBox(
                            height: 15.v,
                          ),
                          Form(
                            key: verifyPhoneNumberProvider.otpFormKey,
                            child: CustomTextFormFieldWidget(
                              enabled:
                                  !verifyPhoneNumberProvider.isLoading(state),
                              controller:
                                  verifyPhoneNumberProvider.otpTextController,
                              labelText: 'Enter 6 digit Code',
                              headingText: 'Enter code sent to your number',
                              autofillHint: AutofillHints.oneTimeCode,
                              maxLength: 6,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              suffixIcon: Icons.key,
                              validator: FormValidationUtils.otpValidator,
                            ),
                          ),
                          BlocBuilder<TimerBloc, TimerState>(
                            builder: (context, timerState) {
                              final button = TextButton(
                                  onPressed:
                                      verifyPhoneNumberProvider.isLoading(state,
                                              timerState: timerState)
                                          ? null
                                          : () {
                                              verifyPhoneNumberProvider.sendOtp(
                                                  context,
                                                  verifyPhoneNumberBloc:
                                                      context.read<
                                                          VerifyPhoneNumberBloc>());
                                            },
                                  child: const Text('Resend Code'));
                              if (timerState is TimerRunningState) {
                                return Column(
                                  children: [
                                    Text(
                                        'Resend code in ${timerState.secondsRemaining} seconds'),
                                    button,
                                  ],
                                );
                              }
                              return button;
                            },
                          ),
                          BlocBuilder<TimerBloc, TimerState>(
                            builder: (context, timerState) {
                              return CustomFilledButtonWidget(
                                  onPressed: () {
                                    verifyPhoneNumberProvider.verifyOtp(context,
                                        user: context
                                            .read<UserSessionProvider>()
                                            .currentUser!,
                                        verifyPhoneNumberBloc: context
                                            .read<VerifyPhoneNumberBloc>());
                                  },
                                  isLoading: verifyPhoneNumberProvider
                                      .isLoading(state),
                                  child: const Text('Verify Otp'));
                            },
                          ),
                          SizedBox(
                            height: 30.v,
                          ),
                          IconButton(
                            onPressed:
                                verifyPhoneNumberProvider.isLoading(state)
                                    ? null
                                    : () {
                                        verifyPhoneNumberProvider.navigateBack;
                                      },
                            icon: const Icon(Icons.arrow_back),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: getScreenPadding(includeTopPadding: false),
                  child: CustomTextButtonWidget(
                    onPressed: () {
                      context.read<UserSessionProvider>().signOut(context);
                    },
                    text: 'Logout',
                    isLoading: verifyPhoneNumberProvider.isLoading(state),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
