import 'package:canteens_fusion/features/auth/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

sealed class SignupState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class SignupInitialState extends SignupState {}

final class RegisteringState extends SignupState {}

final class UserSignupSuccessState extends SignupState {
  final UserEntity user;

  UserSignupSuccessState({required this.user});

  @override
  List<Object?> get props => [user];
}

final class SignupErrorState extends SignupState {
  final String errorMsg;

  SignupErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];
}
