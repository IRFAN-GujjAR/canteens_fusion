import 'package:canteens_fusion/core/constants/user_type_constants.dart';
import 'package:equatable/equatable.dart';

class SignupRegisterUserParams extends Equatable{
  final String email,password;
  final UserType userType;

  const SignupRegisterUserParams({required this.email,required this.password,required this.userType});

  @override
  List<Object?> get props => [email,password,userType];
}