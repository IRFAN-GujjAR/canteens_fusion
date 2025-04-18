part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class AuthLoginEvent extends AuthEvent {
  final LoginParams loginParams;

  AuthLoginEvent(this.loginParams);
  @override
  List<Object?> get props => [loginParams];
}
