part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class AuthInitialState extends AuthState {}

final class AuthLoggingInState extends AuthState {}

final class UserLoggedInState extends AuthState {
  final UserEntity user;

  UserLoggedInState({required this.user});

  @override
  List<Object?> get props => [user];
}

final class AuthWrongUserTypeErrorState extends AuthState {
  final String errorMsg;

  AuthWrongUserTypeErrorState({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}

final class AuthLoginErrorState extends AuthState {
  final String errorMsg;

  AuthLoginErrorState({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}
