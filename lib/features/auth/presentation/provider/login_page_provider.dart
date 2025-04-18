import 'package:canteens_fusion/core/constants/user_type_constants.dart';
import 'package:canteens_fusion/features/auth/domain/usecases/params/login_params.dart';
import 'package:canteens_fusion/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';

final class LoginPageProvider extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;
  final _emailTextController = TextEditingController();
  TextEditingController get emailTextController => _emailTextController;
  final _passwordTextController = TextEditingController();
  TextEditingController get passwordTextController => _passwordTextController;
  bool _hidePassword = true;
  bool get hidePassword => _hidePassword;
  set setHidePassword(bool hidePassword) {
    _hidePassword = hidePassword;
    notifyListeners();
  }

  void onLoginPress({required AuthBloc authBloc, required UserType userType}) {
    if (formKey.currentState!.validate()) {
      setHidePassword = true;
      authBloc.add(AuthLoginEvent(
          LoginParams(
          email: emailTextController.text.trim(),
          password: passwordTextController.text,
          userType: userType)));
    }
  }
}
