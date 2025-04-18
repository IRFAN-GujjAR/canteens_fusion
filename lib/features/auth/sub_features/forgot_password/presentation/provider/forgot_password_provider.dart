import 'package:canteens_fusion/features/auth/sub_features/forgot_password/presentation/bloc/forgot_password_bloc.dart';
import 'package:canteens_fusion/features/auth/sub_features/forgot_password/presentation/bloc/forgot_password_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class ForgotPasswordProvider {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;
  final _emailTextController = TextEditingController();
  TextEditingController get emailTextController => _emailTextController;

  void sendPasswordResetEmail(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context
          .read<ForgotPasswordBloc>()
          .add(ForgotPasswordEvent(email: emailTextController.text.trim()));
    }
  }
}
