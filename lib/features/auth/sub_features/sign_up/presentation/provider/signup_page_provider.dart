import 'package:canteens_fusion/core/constants/user_type_constants.dart';
import 'package:canteens_fusion/core/entities/signup_password_model.dart';
import 'package:canteens_fusion/core/utils/form_validation/form_validation_utils.dart';
import 'package:canteens_fusion/features/auth/sub_features/sign_up/domain/usecases/params.dart';
import 'package:canteens_fusion/features/auth/sub_features/sign_up/presentation/bloc/signup_bloc.dart';
import 'package:canteens_fusion/features/auth/sub_features/sign_up/presentation/bloc/signup_events.dart';
import 'package:flutter/material.dart';

final class SignupPageProvider extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;
  final _emailTextController = TextEditingController();
  TextEditingController get emailTextController => _emailTextController;
  final _passwordTextController = TextEditingController();
  TextEditingController get passwordTextController => _passwordTextController;
  final _reEnterPasswordTextController = TextEditingController();
  TextEditingController get reEnterPasswordTextController =>
      _reEnterPasswordTextController;

  bool _hidePassword = true;
  bool get hidePassword => _hidePassword;

  set setHidePassword(bool hidePassword) {
    _hidePassword = hidePassword;
    notifyListeners();
  }

  bool _hidereRenterPassword = true;
  bool get hideReEnterPassword => _hidereRenterPassword;
  set setHideReEnterPassword(bool hideReEnterPassword) {
    _hidereRenterPassword = hideReEnterPassword;
    notifyListeners();
  }

  SignupPasswordEntity _signupPasswordModel = const SignupPasswordEntity(
      hasMinLength: false,
      hasMinLowercase: false,
      hasMinUppercase: false,
      hasDigit: false,
      hasMinSpecialChar: false);
  SignupPasswordEntity get signupPasswordEntity => _signupPasswordModel;
  set setSignupPasswordModel(SignupPasswordEntity signupPasswordEntity) {
    _signupPasswordModel = signupPasswordEntity;
    notifyListeners();
  }

  void onSignupPress(
      {required SignupBloc signupBloc, required UserType userType}) {
    if (formKey.currentState!.validate()) {
      setHidePassword = true;
      setHideReEnterPassword = true;
      signupBloc.add(RegisterUserEvent(SignupRegisterUserParams(
          email: emailTextController.text.trim(),
          password: _passwordTextController.text,
          userType: userType)));
    }
  }

  void onPasswordChanged(String? password) {
    if (password != null) {
      setSignupPasswordModel =
          FormValidationUtils.passwordSignupValidator(password);
    }
  }

  String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) return 'Please enter a password';
    setSignupPasswordModel =
        FormValidationUtils.passwordSignupValidator(password);
    return signupPasswordEntity.requirementMsg;
  }

  String? reEnterPasswordValidator(String? password) {
    if (password == null || password.isEmpty) return 'Please enter a password';
    if (!_bothPasswordsMatch) {
      return 'Password do not match';
    }
    return null;
  }

  bool get _bothPasswordsMatch {
    return _passwordTextController.text == _reEnterPasswordTextController.text;
  }
}
