import 'package:canteens_fusion/core/blocs/timer_bloc/timer_bloc.dart';
import 'package:canteens_fusion/core/providers/user_session_provider.dart';
import 'package:canteens_fusion/core/utils/common_utils.dart';
import 'package:canteens_fusion/core/utils/dialogs/dialogs_utils.dart';
import 'package:canteens_fusion/core/utils/navigation/navigation_pages_constants.dart';
import 'package:canteens_fusion/core/utils/navigation/navigation_utils.dart';
import 'package:canteens_fusion/core/utils/print_utils.dart';
import 'package:canteens_fusion/features/auth/domain/entities/user_entity.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/phone_number/params.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_phone_number/domain/usecases/params/verify_otp_params.dart';
import 'package:canteens_fusion/features/auth/sub_features/verify_phone_number/presentation/bloc/verify_phone_number_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class VerifyPhoneNumberPageProvider extends ChangeNotifier {
  final _phoneNumberFormKey = GlobalKey<FormState>();
  final _otpFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> get phoneNumberFormKey => _phoneNumberFormKey;
  GlobalKey<FormState> get otpFormKey => _otpFormKey;
  final _phoneNumberTextController = TextEditingController()..text = '+92 ';
  TextEditingController get phoneNumberTextController =>
      _phoneNumberTextController;
  final _otpTextController = TextEditingController();
  TextEditingController get otpTextController => _otpTextController;
  final _pageController = PageController(initialPage: 0);
  PageController get pageController => _pageController;
  String get phoneNumber =>
      phoneNumberTextController.text.toString().replaceAll(' ', '');

  final List<String> _alreadyInUseNumbers = [];
  set setAlreadyInUseNumber(String number) {
    if (!_alreadyInUseNumbers.contains(number)) {
      _alreadyInUseNumbers.add(number);
    }
  }

  bool _showForwardNavigationArrow = false;
  bool get showForwardNavigationArrow => _showForwardNavigationArrow;
  set setShowForwardNavigationArrow(bool showForwardNavigationArrow) {
    _showForwardNavigationArrow = showForwardNavigationArrow;
    notifyListeners();
  }

  void sendOtp(BuildContext context,
      {required VerifyPhoneNumberBloc verifyPhoneNumberBloc}) {
    if (_pageController.page == 1 ||
        _phoneNumberFormKey.currentState!.validate()) {
      hideKeyBoard(context);
      if (_alreadyInUseNumbers.contains(phoneNumber)) {
        DialogUtils.showErrorDialog(context,
            message:
                'This number is already registered with another user. Please use a different phone number');
      } else {
        verifyPhoneNumberBloc.add(
            StartVerificationVerifyPhoneNumberEvent(phoneNumber: phoneNumber));
      }
    }
  }

  void verifyOtp(BuildContext context,
      {required UserEntity user,
      required VerifyPhoneNumberBloc verifyPhoneNumberBloc}) {
    if (_otpFormKey.currentState!.validate()) {
      hideKeyBoard(context);
      verifyPhoneNumberBloc.add(VerifyOtpPhoneNumberEvent(
          verifyOtpParams: VerifyPhoneNumberVerifyOtpParams(
              otp: otpTextController.text.trim()),
          updatePhoneNumberParams: UserUpdatePhoneNumberParams(
              phoneNumber: phoneNumber, userType: user.userType)));
    }
  }

  void get navigateToOtpPage {
    if (_pageController.page == 0) {
      notifyListeners();
      _pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    }
  }

  void get navigateBack {
    otpTextController.clear();
    notifyListeners();
    _pageController.previousPage(
        duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
  }

  void get updateNotifier {
    notifyListeners();
  }

  bool isLoading(VerifyPhoneNumberState state, {TimerState? timerState}) {
    final verifyPhoneNumberLoading = state is SendingCodeToPhoneNumberState ||
        state is OtpVerifyingPhoneNumberState;
    if (timerState != null) {
      return verifyPhoneNumberLoading || timerState is TimerRunningState;
    }
    return verifyPhoneNumberLoading;
  }

  void handleVerifyPhoneNumberBloc(
      BuildContext context, VerifyPhoneNumberState state) {
    switch (state) {
      case VerifyPhoneNumberInitial():
      case SendingCodeToPhoneNumberState():
      case OtpVerifyingPhoneNumberState():
        printDebugMesg(
            dartFileName: runtimeType.toString(), msg: state.toString());
        break;
      case CodeSentSuccessfullyState():
        context.read<TimerBloc>().add(StartTimerEvent());
        setShowForwardNavigationArrow = true;
        navigateToOtpPage;
        break;
      case VerificationCompletedPhoneNumberState():
        break;
      case VerifyPhoneNumberErrorState():
        DialogUtils.showErrorDialog(context, message: state.errorMsg);
        break;
      case OtpVerificationSuccessPhoneNumberState():
        final userSessionProvider = context.read<UserSessionProvider>();
        userSessionProvider.reloadUser.then((value) {
          NavigationUtils.navigate(
              context: context,
              removePreviousPages: true,
              commonNavigationPageType:
                  CommonNavigationPageType.completeProfile);
        });
        break;
      case OtpVerificationErrorState():
        DialogUtils.showErrorDialog(context, message: state.errorMsg);
        break;
      case PhoneNumberAlreadyInUseByOtherUserVerifyPhoneNumberState():
        DialogUtils.showErrorDialog(context, message: state.msg);
        setAlreadyInUseNumber = phoneNumber;
        setShowForwardNavigationArrow = false;
        navigateBack;
        break;
      case PhoneNumberAlreadyLinkedVerifyPhoneNumberState():
        final userSessionProvider = context.read<UserSessionProvider>();
        userSessionProvider.reloadUser.then((value) {
          NavigationUtils.navigate(
              context: context,
              removePreviousPages: true,
              commonNavigationPageType:
                  CommonNavigationPageType.completeProfile);
        });
        break;
    }
  }
}
