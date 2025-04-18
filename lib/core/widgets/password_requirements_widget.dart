import 'package:canteens_fusion/core/entities/signup_password_model.dart';
import 'package:canteens_fusion/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

final class PasswordRequirementsWidget extends StatelessWidget {
  final SignupPasswordEntity _signupPasswordEntity;

  const PasswordRequirementsWidget(
      {Key? key, required SignupPasswordEntity signupPasswordEntity})
      : _signupPasswordEntity = signupPasswordEntity,
        super(key: key);

  Widget _buildTextWidget(String txt, bool satisfied) {
    return Text(
      '- $txt',
      style:
          TextStyle(color: satisfied ? Colors.green : Colors.red, fontSize: 12),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.h, right: 0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            'Password must contain following things: ',
            style: TextStyle(fontSize: 13),
          ),
          _buildTextWidget(
              'minimum 6 characters', _signupPasswordEntity.hasMinLength),
          _buildTextWidget(
              'lowercase letter', _signupPasswordEntity.hasMinLowercase),
          _buildTextWidget(
              'uppercase letter', _signupPasswordEntity.hasMinUppercase),
          _buildTextWidget('atleast one digit', _signupPasswordEntity.hasDigit),
          _buildTextWidget(
              'special character', _signupPasswordEntity.hasMinSpecialChar),
        ],
      ),
    );
  }
}
