import 'package:equatable/equatable.dart';

sealed class ForgotPasswordState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class InitialForgotPasswordState extends ForgotPasswordState {}

final class SendingEmailForgotPasswordState extends ForgotPasswordState {}

final class EmailSentForgotPasswordState extends ForgotPasswordState {
  final String email;

  EmailSentForgotPasswordState({required this.email});

  @override
  List<Object?> get props => [email];
}

final class ErrorForgotPasswordState extends ForgotPasswordState {
  final String errorMsg;

  ErrorForgotPasswordState({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}
