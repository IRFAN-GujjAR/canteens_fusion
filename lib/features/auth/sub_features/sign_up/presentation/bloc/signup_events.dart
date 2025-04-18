import 'package:canteens_fusion/features/auth/sub_features/sign_up/domain/usecases/params.dart';
import 'package:equatable/equatable.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object?> get props => [];
}

final class RegisterUserEvent extends SignupEvent {
  final SignupRegisterUserParams params;

  const RegisterUserEvent(this.params);

  @override
  List<Object> get props => [params];
}
