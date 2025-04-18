import 'package:canteens_fusion/core/blocs/timer_bloc/timer_bloc.dart';
import 'package:canteens_fusion/core/constants/images_constants.dart';
import 'package:canteens_fusion/core/utils/common_utils.dart';
import 'package:canteens_fusion/core/utils/dialogs/dialogs_utils.dart';
import 'package:canteens_fusion/core/utils/navigation/navigation_pages_constants.dart';
import 'package:canteens_fusion/core/utils/navigation/navigation_utils.dart';
import 'package:canteens_fusion/core/utils/print_utils.dart';
import 'package:canteens_fusion/core/utils/provider_utils.dart';
import 'package:canteens_fusion/core/utils/size_utils.dart';
import 'package:canteens_fusion/core/widgets/logout_button_widget.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_email/presentation/bloc/verify_email_bloc.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_email/presentation/bloc/verify_email_events.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_email/presentation/bloc/verify_email_states.dart';
import 'package:canteens_fusion/core/providers/user_session_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userSessionProvider =
        ProviderUtils<UserSessionProvider>().getProvider(context: context);
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<VerifyEmailBloc, VerifyEmailState>(
        listener: (context, state) {
          switch (state) {
            case VerifyEmailInitialState():
            case SendingEmailVerifyState():
            case ReloadingUserEmailVerifyState():
            case UserReloadedEmailVerifyState():
              printDebugMesg(
                  dartFileName: runtimeType.toString(), msg: state.toString());
              break;
            case EmailVerificationSentVerifyEmailState():
              context.read<TimerBloc>().add(StartTimerEvent());
              break;
            case EmailVerificationSuccessState():
              userSessionProvider.setCurrentUser = state.user;
              NavigationUtils.navigate(
                  context: context,
                  commonNavigationPageType:
                      CommonNavigationPageType.verifyPhoneNumber,
                  removePreviousPages: true);
              break;
            case VerifyEmailErrorState():
              DialogUtils.showErrorDialog(context, message: state.errorMsg);
              break;
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: getScreenPadding(),
            child: Center(
              child: Column(
                children: [
                  Image.asset(ImageConstants.emailConfirmationCode),
                  SizedBox(
                    height: 40.v,
                  ),
                  Text(
                    'A confirmation email is sent to your email, please check your email inbox',
                    style: TextStyle(color: Colors.grey[700]),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20.v,
                  ),
                  BlocBuilder<TimerBloc, TimerState>(
                    builder: (context, state) {
                      final isTimerRunning = state is TimerRunningState;
                      final resendEmailButton =
                          BlocBuilder<VerifyEmailBloc, VerifyEmailState>(
                        builder: (context, state) {
                          final isSendingEmail =
                              (state is SendingEmailVerifyState);
                          return TextButton(
                              onPressed: isSendingEmail || isTimerRunning
                                  ? null
                                  : () {
                                      context.read<VerifyEmailBloc>().add(
                                          SendEmailVerifyEmailEvent(
                                              user: userSessionProvider
                                                  .getCurrentUser));
                                    },
                              child: const Text('Resend Email'));
                        },
                      );
                      if (isTimerRunning) {
                        return Column(
                          children: [
                            Text(
                              'Resend email in ${state.secondsRemaining} seconds',
                              style: const TextStyle(color: Colors.grey),
                            ),
                            SizedBox(
                              height: 20.v,
                            ),
                            resendEmailButton
                          ],
                        );
                      }
                      return resendEmailButton;
                    },
                  ),
                  SizedBox(
                    height: 20.v,
                  ),
                  const LogoutButtonWidget()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
