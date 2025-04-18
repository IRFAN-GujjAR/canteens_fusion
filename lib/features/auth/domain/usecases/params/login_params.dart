import 'package:canteens_fusion/core/constants/user_type_constants.dart';
import 'package:equatable/equatable.dart';

class LoginParams extends Equatable {
  final String email;
  final String password;
  final UserType userType;

  const LoginParams(
      {required this.email, required this.password, required this.userType});

  @override
  List<Object?> get props => [email, password, userType];
}
